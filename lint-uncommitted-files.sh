#!/bin/bash
# Lint unstaged and staged files in the current repo.
#
# author: andreasl

staged_unstaged_files_lines="$(git diff --name-only HEAD)"
mapfile -t staged_unstaged_files <<<"$staged_unstaged_files_lines"
untracked_files_lines="$(git ls-files --others --exclude-standard)"
mapfile -t untracked_files <<<"$untracked_files_lines"

files="${staged_unstaged_files[@]}"
files+=("${untracked_files[@]}")

lint_bash_file() {
    printf -- '\e[1m%s:\e[0m\n' "$1"
    shellcheck "$1"
    printf -- '---\n'
}

lint_lua_file() {
    printf -- '\e[1m%s:\e[0m\n' "$1"
    luacheck "$1" --codes
    printf -- '---\n'
}

lint_python_file() {
    printf -- '\e[1m%s:\e[0m\n' "$1"
    flake8 "$1"
    pylint "$1"
    printf -- '---\n'
}

lint_yaml_file() {
    printf -- '\e[1m%s:\e[0m\n' "$1"
    yamllint "$1"
    printf -- '---\n'
}

for file in "${files[@]}"; do
    if [[ "$file" == *".sh" ]]; then
        lint_bash_file "$file"
    elif [[ "$file" == *".lua" ]]; then
        lint_lua_file "$file"
    elif [[ "$file" == *".py" ]]; then
        lint_python_file "$file"
    elif [[ "$file" == *".yml" ]] || [[ "$file" == *".yaml" ]]; then
        lint_yaml_file "$file"
    fi
done
