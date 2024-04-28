#!/bin/bash
echo \* $* all the arguments
while getopts ":af:z" option; do
    case $option in
    a)
        echo received -a
        ;;
    f)
        echo received -f with $OPTARG
        ;;
    z)
        echo received -z
        ;;
    :)
        echo "option -$OPTARG needs an argument"
        ;;
    *)
        echo "invalid option -$OPTARG"
        ;;
    esac
done
