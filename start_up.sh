#!/bin/bash

# **********************************************************
# * Author        : Rany010
# * Email         : rany010.y@gmail.com
# * Create time   : 2023-11-18
# * Filename      : start_up.sh
# * Description   : ***
# **********************************************************


soft_path="$1"
version="${2:-1.0.0}"

function usage() {
    if [ -z "$soft_path" ]; then
        echo "Usage: $0 soft_path version(optional, default: 1.0.0), eg: $0 /usr/bin/standard_deb 1.0.0"
        exit 1
    fi

    if [ ! -f "$soft_path" ]; then
        echo "File not found: $soft_path"
        exit 1
    fi

    echo "soft_path: $soft_path"
    echo "version: $version"
}

function confirm() {
    read -r -p "Please confirm that the software package and version are correct and press y/Y to continue. [y/N]: " response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        return 0
    else
        exit 1
    fi
}

echo " "
echo "--------------------------------------------------------------------------"
echo "curr time: $(date '+%Y-%m-%d %H:%M:%S')"
echo "--------------------------------------------------------------------------"
echo " "

usage

# confirm 

bash init.sh "$soft_path" "$version" >> ./init.log 2>&1 &
if [ $? -ne 0 ]; then
    echo "init failed"
    exit 1
fi

bash create_deb.sh "$soft_path" "$version" >> ./create_deb.log 2>&1 &
if [ $? -ne 0 ]; then
    echo "create_deb failed"
    exit 1
fi