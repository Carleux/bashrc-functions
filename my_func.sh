#!/bin/bash
# my_functions.sh
# This file contains reusable Bash functions

# Example function: greet a user
greet_user() {
    local name="$1"
    if [[ -z "$name" ]]; then
        echo "Error: No name provided to greet_user()" >&2
        return 1
    fi
    echo "Hello, $name!"
}

