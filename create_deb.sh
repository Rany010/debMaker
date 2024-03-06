#!/bin/bash

# **********************************************************
# * Author        : Rany010
# * Email         : rany010.y@gmail.com
# * Create time   : 2023-11-18
# * Filename      : create_deb.sh
# * Description   : ***
# **********************************************************

soft_path="$1"
version="$2"

function load_ini() {
    section_key=$1
    conf_key=$2
    result=`awk -F '=' '/\['$section_key'\]/{a=1}a==1&&$1~/'$conf_key'/{print $2;exit}' params.ini`
    echo $result
}

function get_dependencies() {
    if [ ! -f "$soft_path" ]; then
        echo "File not found: $soft_path"
        exit 1
    fi

    dependencies=()
    while IFS= read -r line; do
        dep=$(echo "$line" | awk '{print $3}')
        [ -n "$dep" ] && dependencies+=("$dep")
    done < <(ldd "$soft_path")

    printf '%s\n' "${dependencies[@]}"

    local lib_path="$soft_path"_deb/usr/lib
    for dependency in "${dependencies[@]}"; do
        [ -n "$dependency" ] && cp --parents "$dependency" "$lib_path"
    done
}

function update_control() {
    local control_path="$soft_path"_deb/DEBIAN/control
    echo "control_path: $control_path"

    soft_name=$(load_ini "SOFTWARE" "name")
    version=$(load_ini "SOFTWARE" "version")
    section=$(load_ini "SOFTWARE" "section")
    priority=$(load_ini "SOFTWARE" "priority")
    architecture=$(load_ini "SOFTWARE" "architecture")
    description=$(load_ini "SOFTWARE" "description")

    echo "Package: $soft_name" > "$control_path"
    echo "Version: $version" >> "$control_path"
    echo "Section: $section" >> "$control_path"
    echo "Priority: $priority" >> "$control_path"
    echo "Architecture: $architecture" >> "$control_path"
    echo "Maintainer: rany010.y@gmail.com" >> "$control_path"
    echo "Description: $description" >> "$control_path"
}

# usage
get_dependencies
update_control
