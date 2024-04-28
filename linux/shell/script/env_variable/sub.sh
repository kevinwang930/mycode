echo script name in subprocess $0
echo process id in subprocess $$


# [[shell keyword has different rules]] 
if [[ -v $a ]]; then
    echo value of a in subprocess is $a
else
    echo "\$a doesn't exist in subprocess"
fi

if [[ -n $a ]]; then
    echo value of a in subprocess is $a
else
    echo "\$a doesn't exist in subprocess"
fi

if [ -n "$a" ]; then
    echo value of a in subprocess is $a
else
    echo "\$a doesn't exist in subprocess"
fi