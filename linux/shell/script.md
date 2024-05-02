# Shell Script
Shell script is a text file that contains a sequence of commands for a UNIX-based operating system.

## shebang
specify the interpreter that the given script will be run with


## syntax
1. ; to separate multiple commands
2. $1-$9 refer to the arguments to a script, $0 is the path of script
3. command exit code
   1. 0 ok
   2. $? return value of last executed command



## variable

1. assign a=b
2. access $a



## quote
1. single quote string literal
2. double quote string literal that allows substitution


## control flow


```
if [ condition ]
then
fi
```
[] needs space to separate from single commands


```
while [ condition ]
do

done
```

```
for variable in {1..N} 
do

done
```

## function
```
name (args) {

}
```
in function, $1-$9 refer to the function args

## expansion
Bash performs expansion upon the text before it carries out command. 

### pathname expansion

```
echo *            // file names of current directory
echo *s
echo ~            // tilde means home path

```



## Command substitution

1. command output as variable `$` can be nested
```
$(command)
`command`
```
2. command output as string literal
```
"command"
```
## Comparison
use `man test` to check the help page
1. numbers
   1. -eq
   2. -ne
   3. -gt
   4. -ge
   5. -lt
2. String
   1. = 
   2. !=
   3. <
   4. >
   5. -n length greater than 0
   6. -z length 0
3. file
   1. -d file directory
   2. -e file exists
   3. -f file exists and is a regular file
   4. -L file is a symbolic link
   5. -r file readable
   6. -w file writable
   7. -x file executable
   8. -s file file exists and has size greater than zero
   9. file1 -nt file2 file1 is newer than file2
   10. file1 -ot file2 older than
## Arithmetic

```
a=$((1+2))
let a=1+2
a=$( expr 1+2 )
```