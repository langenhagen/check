#!/bin/bash
# Identify possible issues in a given ini file.
#
# author: andreasl

ini_file="$1"

checks_array=(
    '[^ ]='  # space before assignment
    '=[^ ]'  # space after assignment
    ', '  # space after comma
)
checks="$(printf '%s|' "${checks_array[@]}")"

grep -EHn "${checks}" "$ini_file"
