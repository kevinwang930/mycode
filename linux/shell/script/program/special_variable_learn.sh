#!/bin/bash
# $0 is the script itself
echo "$0 $1 $2"

# $# is arguments counts
echo $#
$1

# $* take all arguments as a whole  can not execute
echo "$*"


# $@ can be used to execute the command passed as arguments
$*
"$@"



for i in "$*"
	do
	echo "$i"
	done

for i in "$@"
do 
	echo "$i"
done


 
