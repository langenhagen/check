#!/bin/bash
# Lint and optionally format the given CMakeLists.txt files.
#
# Call cmake-format and cmake-lint one after another for all given files.
#
# Usage:
#   lint-cmake-files.sh [-f|--format] <FILE> [<FILE>] ...
#
# author: andreasl

files=()
format=
while [ "$#" -gt 0 ]; do
    case "$1" in
    -f | --format)
        format=-i
        ;;
    *)
        files+=("$1")
        ;;
    esac
    shift
done

for file in "${files[@]}"; do
    printf '\e[1m=== %s ===\e[m\n' "$file"

    printf '*** cmake-format %s ***\n' "$(cmake-format --version)"
    cmake-format ${format} "$file"

    printf '*** cmake-lint %s ***\n' "$(cmake-lint --version)"
    cmake-lint "$file"
done
