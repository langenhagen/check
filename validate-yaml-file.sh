#!/usr/bin/env bash
# Validate the given YAML file via Python.
# Requires Python and the Python package `pyyaml` to be available.
#
# Consider using the tool yamllint https://github.com/adrienverge/yamllint.
#
# based on:
# https://stackoverflow.com/questions/3971822/how-do-i-validate-my-yaml-file-from-command-line
#
# author: andreasl

file_path="$1"
if [ -z "$file_path" ] || [ ! -f "$file_path" ]; then
    >&2 printf 'File does not exist: %s\n' "$file_path"
    exit 1
fi

python -c 'import sys, yaml; yaml.safe_load(sys.stdin); print("YAML valid")' <"$file_path"
