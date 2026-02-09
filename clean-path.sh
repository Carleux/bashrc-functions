function wrap_spaces() {
  echo "$1" | sed -E "s/([^/]* [^/]*)/'&'/g"
}

function clean_user_path {
    if [[ "$PATH" == *"'"* ]]; then
        return 0
    fi
    org_ifs=$IFS
    IFS=':' read -ra paths <<< "$PATH"
    modified_paths=()
    for path in "${paths[@]}"; do
        modified_paths+=("$(wrap_spaces "$path")")
    done
    new_path=$(IFS=':'; echo "${modified_paths[*]}")
    IFS=$org_ifs
    export PATH=$new_path
    echo $PATH
}
