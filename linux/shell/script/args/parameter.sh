#!/bin/zsh

echo this script is called $0
echo The first argument is $1

echo The second argument is $2
echo The third argument is $3
echo \$ $$ PID of the script
echo \# $# count arguments
echo \? $? last return code
echo \* $* all the arguments

if [ "$#" -eq "0" ]; then
    echo You have to give at least one parameter.
    # exit 1
else 

# use shift to move parameters down by one
    p=1
    while (( $# )); do
        # eval y='$'$p
        echo the ${p}th parameter is $1
        p=$(($p + 1))
        shift
    done
fi

# set shell parameter
set my name is kevin
echo "1st parameter by set is" $1

# parameter expansion
for i in 1 2
do 
    echo ${i}_parameter
done

unset foo
echo foo with default ${foo:-bar}
foo=fud 
echo foo with default ${foo:-bar}
foo=/usr/bin/X11/startx
echo ${foo#*/}
echo ${foo##*/}
bar=/usr/local/etc/local/networks
echo ${bar%local*}
echo ${bar%%local*}
