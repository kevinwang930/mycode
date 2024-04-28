#!/bin/zsh
test 10 -gt 55
echo $?
[ 56 -gt 55 ] && echo true || echo false
[ 56 -gt 55 -a 10 -gt 24 ] && echo true || echo false

if [ -f test.sh ]; then
    echo test.sh exists
else
    echo test.sh not found!
fi

if test -f if.sh; then
    echo if.sh exists!
else
    echo if.sh not found!
fi
