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
-p filter protocol exampel -p tcp
```

# lsof

list open file information about files opened by processes
```
-i  [46][protocol][@hostname|hostaddr][:service|port]  selects the listing of files any of whose internet address matches the address specified in i
-n show network address as numbers
-P show port numbers
```



# ps

process status

```
-a  Display info about other users' processes as well as your own, skip processes which do not have controlling terminal
-x  including processes which do not have a controlling terminal.
-f  display format with basic info and command
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
-delete delete found file or directoreis
```


# iftop
display brandwidth usage.


# telnet

The telnet command is used to communicate with another host using the TELNET protocol.

telnet is based on TCP, can be used to check host and port availability.

```
telnet host port
```



# sysctl

configure kernel parameters at runtime

```
sysctl -a | grep net.ipv4.ip_local_port    port range
```

# ulimit

set or report user resource limit, often referred as soft limit.

```
ulimit -n     limit on the number of the file descriptors a process may have
ullimit -a    list all the current resource limits
```

# nc

netcat is used for just about anything involving TCP or UDP.

```
nc [option] [hostname] [port[s]]
options:
-l port listen for incoming connection
```

# dig

(dig) domain information groper is a flexible tool for interrogating DNS name servers. 
dig @server name type

# tar

manipulate tape archives

```
-x extract to disk from the archive
-z --gunzip --gzip compress the resulting archive with gzip, In extract or list modes, this option is ignored.
-f file  Read the archive from or write the archive to the specified file.
```


# curl

curl is a tool for transferring data from or to a server using URLs. curl supports many protocols, the default is HTTP. 


```
-X, --request <method>  example http method: get put post delete.
-x, --proxy [protocol://]host[:port]   using a proxy.
-H, --header extra header to include in information sent.
-d, --data <data> sends the specified data in a post request to the HTTP server.
-F, --form <name=content> For HTTP protocol family, emulate a filled-in form. 
```


# ps

ps -ef    

# nslookup
query Internet name server interactively
```
nslookup [-option] [name | -] [server]
```
