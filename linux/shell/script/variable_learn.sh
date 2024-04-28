A=8
echo $A

# readonly variable
readonly B=10
B=11
if [ ! $? -eq 0 ];then
	echo the result of last command is wrong
fi


# unset variable

unset A
if [ -z $A ]; then
	echo A is null after unset
fi


# variable is of string type can not do arithmatic operation

c=1+2
echo $c

# variable in single quote and double quotes

d=8
echo "d value is $d"
echo 'd value is '"$d"

# variable value with blank needs quotes
e="I like walking"
echo $e



