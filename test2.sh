#!/bin/bash

mkdir test2
pushd test2
    echo "c file" > "a.c"
    echo "no change" > "a.c.orig"

    ../script.sh
    if [ "$(cat a.c.orig)" != "no change" ]
    then
        echo "Existing file changed"
        exit 1
    fi
popd
echo "Passed test 2"
rm test2 -r
