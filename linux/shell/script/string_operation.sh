# use cut to get the select column with delimeters

echo $PATH
f1=`echo $PATH | cut -d ":" -f 1`
echo $f1


# use tr to split string

f2=`echo $PATH | tr ":" "\n"`
echo "$f2"


