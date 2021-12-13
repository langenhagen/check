#!/bin/bash
# Identify possible issues in the given Dockerfiles.
#
# author: andreasl
shopt -s globstar

files=("$@")
[[ ${#files[@]} -eq 0 ]] && mapfile -t files <<< "$(ls -1 -- **/Dockerfile)"

for file in "${files[@]}"; do
    printf '\e[1m=== %s ===\e[m\n' "$file"
    docker run --rm -i hadolint/hadolint < "$file"
done
