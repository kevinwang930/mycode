# sudo

sudo let user executes a command as the superuser or another user


# grep
grep command line to search for matching text

```
etc % man grep | grep  "grep" | grep echo
```

# history
a built in shell command to record history of command executed.

!num to execute commands in history


# sed

stream editor

sed command format `[address[,address]]function[arguments]` address can be omitted

## s mod for substitution
s/regex/substitution
```
echo hello | sed s/h/i/
```
## a mod for append
sed /regex/a\text

## d mode for deleteion
```
sed '5d' test.txt
```

# uniq
report or filter out repeated lnes

# xargs
command allows you o use ouput of one command as arguments of another command

# awk


# netstat
show network status

| protocol | Recv-Q | Send-Q | Local Address | Foreign Address | state |
| -------- | ------ | ------ | ------------- | --------------- | ----- |
|          |        |        |               |                 |       |



```
-a show the state of all sockets including the hidden server processes.
-n show network addresses as numbers
```


# ps

process status

```
-a  Display info about other users' processes as well as your own, skip processes which do not have controlling terminal
-x  including processes which do not have a controlling terminal.

```


# find
The find utility recursively descends the directory tree for each path listed, evaluating an expression in terms of each file in the tree.

## Synopsis
```
find [-H | -L | -P] [-EXdsx] [-f path] path ... [expression]
find [-H | -L | -P] [-EXdsx] -f path [path ...] [expression]

expression := primaries operands

-L  return real file info and file type for symbolic link.

-name pattern 
```
