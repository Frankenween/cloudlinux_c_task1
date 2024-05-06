#!/bin/bash

expected=(
    "1.c" "1.c.orig" "2.b" "aboba.a.b.c" "aboba.a.b.c.orig"
    "d1/c" "d1/war.and" "d1/peace.c" "d1/peace.c.orig"
    "dir.c/test.c" "dir.c/test.c.orig" "dir.c/not a c file" "dir.c/a C file.c" "dir.c/a C file.c.orig" 
    "d1" "dir.c"
    )

mkdir test1
pushd test1
    touch 1.c
    touch 2.b
    touch aboba.a.b.c

    mkdir d1
    pushd d1
        touch c
        touch war.and
        touch peace.c
    popd

    mkdir dir.c # directory for checking that script does not make its copy
    pushd dir.c
        touch test.c
        touch "not a c file"
        touch "a C file.c"
    popd

    ../script.sh

    got=()
    for name in * */*;
    do
        got+=( "$name" )
    done


    if [ ${#got[@]} -ne ${#expected[@]} ]
    then 
        echo "Sizes differ: ${#got[@]} vs ${#expected[@]}. Expected:"
        echo "${expected[@]}"
        echo "Got:"
        echo "${got[@]}"
        exit 1
    fi
    # Now sizes are the same
    # Check if we contain all expected files
    for name in "${expected[@]}";
    do
        if [ ! -e "$name" ]
        then
            echo "Didn't find expected file $name"
            exit 1
        fi
    done
popd

echo "Passed test 1"
rm test1 -r