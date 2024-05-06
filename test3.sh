#!/bin/bash

expected=(
    "restricted.c" "real c file.c" "real c file.c.orig"
    "restricted dir/c file in restr.c" "restricted dir/dummy.file"
    "simple dir/c file.c" "simple dir/c file.c.orig" "simple dir/eue.not_c"
    "restricted dir" "simple dir"
    )

mkdir test3
pushd test3
    touch "restricted.c"
    chmod -rw "restricted.c"
    touch "real c file.c"
    
    mkdir "restricted dir"
    pushd "restricted dir"
        touch "c file in restr.c"
        touch "dummy.file"
    popd
    chmod -rwx "restricted dir"

    mkdir "simple dir"
    pushd "simple dir"
        touch "c file.c"
        touch "eue.not_c"
    popd

    ../script.sh

    chmod +rw "restricted.c"
    chmod +rwx "restricted dir"

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

echo "Passed test 3"
rm test3 -rf