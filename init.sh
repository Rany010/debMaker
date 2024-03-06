#!/bin/bash

# **********************************************************
# * Author        : Rany010
# * Email         : rany010.y@gmail.com
# * Create time   : 2023-11-18
# * Filename      : init.sh
# * Description   : ***
# **********************************************************

file_path="$1"
base_dir=$(dirname "$file_path")
soft_name=$(basename "$file_path")
target_dir="$base_dir/$soft_name"_deb

echo "file_path: $file_path"
echo "base_dir: $base_dir"
echo "soft_name: $soft_name"
echo "target_dir: $target_dir"

if [ -e "$target_dir" ] && [ ! -d "$target_dir" ]; then
    echo "$target_dir already exists and is not a directory. Exiting."
    exit 1
fi

mkdir -p "$target_dir/DEBIAN"
mkdir -p "$target_dir/usr/bin"
mkdir -p "$target_dir/usr/share/applications"
mkdir -p "$target_dir/usr/share/icons"
mkdir -p "$target_dir/usr/share/doc"
mkdir -p "$target_dir/usr/lib"
mkdir -p "$target_dir/opt"

touch "$target_dir/DEBIAN/control"
touch "$target_dir/DEBIAN/postinst"
touch "$target_dir/DEBIAN/postrm"

touch "$target_dir/usr/bin/$soft_name"
touch "$target_dir/usr/share/applications/$soft_name.desktop"
touch "$target_dir/opt/launch.sh"

tree "$target_dir"
