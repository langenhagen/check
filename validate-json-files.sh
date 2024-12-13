#!/bin/bash
# Validate all JSON files in given folder.
#
# author: andreasl

target_dir="${1:-.}"
[ -d "$target_dir" ] || { >&2 echo "Directory ${target_dir} does not exist."; exit 1; }

for file in "$target_dir"/*.json; do
    [ -f "$file" ] || continue

    jq empty "$file" 2>/dev/null && echo "Valid: $file" || echo "Invalid!: $file"
done
