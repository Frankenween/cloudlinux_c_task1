# Bash script for making .c files copies
`./script.sh` does the thing. It does not follow symlinks, copies regular files only and does not override existing ones.

For testing purposes there is a script `./run_tests.sh`.

- Test 1 checks that script is sane and does not copy directories ending with ".c"
- Test 2 checks that script does not override existing files
- Test 3 checks that script just skips inaccessible files and directories