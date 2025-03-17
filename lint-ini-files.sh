#!/bin/bash
# Identify possible issues in the given ini files.
#
# author: andreasl

checks_array=(
    '[^ ]='  # space before assignment
    '=[^ ]'  # space after assignment
    ', '     # space after comma
)
checks="$(printf '%s|' "${checks_array[@]}")"

for ini_file in "$@"; do
    grep -EHn "${checks}" "$ini_file"
done
