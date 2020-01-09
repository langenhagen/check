#!/bin/bash
# Report whether all python files under a given directory are syntactically correct.
#
# In order to test against Python 2 or Python 3, activate the Python version you want to check
# against, so that calling `python` starts the desired version, e.g. via`conda activate`.
#
# author: andreasl

directory="${1:-.}"
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
verbose=false
[ -n "$2" ] && verbose=true;

check_file() {
    file="$1"
    output="$(python "${script_dir}/check-if-python-file-is-syntactically-correct.py" "$file")"
    if [ "$?" != 0 ] && [ "$verbose" == 'false' ]; then
        printf 'Errors in file: %s\n' "$1"
    elif [ "$verbose" == 'true' ]; then
        printf 'File "%s":\n%s\n' "$1" "$output"
    fi
}
export -f check_file
export script_dir
export verbose

find "$directory" -iname "*.py" -exec bash -c 'check_file "{}"' \;
