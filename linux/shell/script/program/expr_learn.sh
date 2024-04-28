#!/bin/bash


# expr evaluate expressions

a=`expr 2 + 3`
echo value of expr a $a 



a=$(expr 2 + 3)
echo value of expr a $a 

a=$(expr $(expr 150 + 157) + 3)
echo value of expr a $a 



# backtip to run sub command and return value
d=`ls -l`
echo "$d"
