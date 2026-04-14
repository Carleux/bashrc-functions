
### SSH ###
# Auto-initialize SSH AGENT and add bitbucket key
SSH_ENV="$HOME/.ssh/agent-environment"
PRIV_KEY="$HOME/.ssh/id_rsa"
GITHUB_KEY="$HOME/.ssh/id_ed25519"
# COREWELL_GITHUB_KEY="$HOME/.ssh/id_github_corewell"

function start_ssh_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add "${PRIV_KEY}";
    /usr/bin/ssh-add "${GITHUB_KEY}";
    /usr/bin/ssh-add "${COREWELL_GITHUB_KEY}";
}

function check_ssh_identities {
    if [ -f "${SSH_ENV}" ]; then
        . "${SSH_ENV}" > /dev/null
        #ps ${SSH_AGENT_PID} doesn't work under cywgin
        ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
            start_agent;
        }
    else
        start_agent;
    fi
}

# check_ssh_identities