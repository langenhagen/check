#!/usr/bin/env bash
# Identify possible issues in the given Dockerfiles.
#
# author: andreasl
shopt -s globstar nullglob

files=("$@")
[[ ${#files[@]} -eq 0 ]] && files=(**/Dockerfile)

for file in "${files[@]}"; do
    printf '\e[1m=== %s ===\e[m\n' "$file"
    docker run --rm -i hadolint/hadolint <"$file"
done
