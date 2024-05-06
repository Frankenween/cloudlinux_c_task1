#!/bin/bash

tests=( "test1" "test2" "test3" )

for test in ${tests[@]};
do
    ./"$test".sh
done