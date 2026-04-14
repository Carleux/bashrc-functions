function get_python_major_version {

    org_ifs=$IFS
    local pyv="$1"
    IFS='.' read -ra version_numbers <<< "$pyv"
    
    for version in "${version_numbers[@]}"; do
        pytnon_version+=($version)
    done
      
   python_major_version="${pytnon_version[0]}"
   echo $python_major_version
}

function get_python_package_version {

    org_ifs=$IFS
    local pyv="$1"
    IFS='.' read -ra version_numbers <<< "$pyv"
    
    for version in "${version_numbers[@]}"; do
        pytnon_version+=($version)
    done
   
   package_version="${pytnon_version[0]}.${pytnon_version[1]}"
   echo $package_version
}


# set_value() {
#     local -n ref=$1
#     ref="Updated Value"
# }

# myvar="Old Value"
# set_value myvar
# echo "$myvar" # Updated Value