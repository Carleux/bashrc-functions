#!/bin/bash

# params
regex=${regex}

# param parser
while [ $# -gt 0 ]; do
   if [[ $1 == *"-"* ]]; then
      param="${1/-/}"
      declare $param="$2"
      echo "$param $2"
   fi
  shift
done

# Assign default regular expression if none was provided
if [[ -n $regex ]]; then
  rgx="$regex"
else 
  rgx='(?:/mnt/c/|/home/'$(whoami)'|[A-Za-z\s/])+/git'
  # rgx='git'
fi

modified_paths=()

function use_git_for_linux {
    org_ifs=$IFS

    if [[ "$PATH" == *"'"* ]]; then
        return 0
    fi
    org_ifs=$IFS
    IFS=':' read -ra paths <<< "$PATH"
    
    echo
    echo ====== REMOVED FROM \$PATH ==========
    for path in "${paths[@]}"; do
        # echo "$path"
        grepped=$(echo $path | grep $rgx -i -P | wc -l)
        if [[ $grepped > 0 ]]; then 
            echo "$path"
        else
            modified_paths+=("$(echo $path)")
        fi


    done
    echo =========================
    echo
    
    new_path=$(IFS=':'; echo "${modified_paths[*]}")
    IFS=$org_ifs
    export PATH=$new_path
    # echo $PATH
}
