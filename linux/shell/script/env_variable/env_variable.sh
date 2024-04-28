a=1
echo this is shell script name $0
echo command prompt $PS1
BASEDIR=$(dirname "$BASH_SOURCE")
echo value of a $a 
echo process id $$
# source $BASEDIR/sub.sh
bash sub.sh


# export a 