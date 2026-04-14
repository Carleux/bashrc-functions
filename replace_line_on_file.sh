#!/bin/bash
replace_line() {
    local target="$1"
    local regex="$2"
    local replacement="$3"
    if [[ ! -f "$target" ]] ; then
        echo "Error: a parameter is wrong replace_line()" >&2
    else
        # echo
        # echo  $target
        # echo  $regex
        # echo  $replacement
        # echo

        sed_cmd="/$regex/{s|$regex|\1$replacement|}"
        # echo "$sed_cmd"
        sed -i -r "$sed_cmd"  $target
        echo
        output=$(cat $target | grep -P "$regex")
        echo "### OUTPUT ###"
        echo "$output"
    fi
}


activate_python(){
    local activate_switch="$1"
    replace_line  '/home/car96315/functions/local_env_vars.sh'  '(export ACTIVATE_PYTHON=)([0-1])' $activate_switch
}