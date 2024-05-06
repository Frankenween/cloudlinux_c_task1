#!/bin/bash

find -name "*.c" -type f -execdir cp -n '{}' '{}'.orig \;