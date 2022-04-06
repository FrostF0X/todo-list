#!/usr/bin/env bash

echo "Current version: ${VERSION}"

if [[ "$1" = "exec" ]]; then
    args=("${@}")
    # shellcheck disable=SC2199
    args=("${args[@]/exec}")
    args_res=()
    for i in "${args[@]}";
    do
        if [ -n "${i// }" ]; then
            args_res+=( "$i" )
        fi
    done
    args=( "${args_res[@]}" )
    if [[ "${#args[@]}" -eq 0 ]]; then
        bash
        exit $?;
    else
        exec "${args[@]}"
        exit $?;
    fi
fi
make -f /Makefile "$@"
