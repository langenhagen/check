#!/bin/bash
# Validate all JSON files in given folder.
#
# author: andreasl

target_dir="${1:-.}"
[ -d "$target_dir" ] || { >&2 echo "Directory ${target_dir} does not exist."; exit 1; }

for file in "$target_dir"/*.json; do
    [ -f "$file" ] || continue

    python3 -c "import json, sys; json.load(open('$file'))" 2>/dev/null

    # shellcheck disable=SC2181
    [ $? -eq 0 ] && echo "Valid: $file" || echo "Invalid!: $file"
done
