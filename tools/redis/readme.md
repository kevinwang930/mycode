# redis conf

redis-server can be started with redis.conf as first arg
```
redis-server /path/to/redis.conf   // start server using redis.conf
```
The redis.conf file contains a number of  directives that have a very simple format:
```
keyword argument1 argument2 ... argumentN
```

## conf details
```
include /path/to/another.conf   // include another conf
loadmodule /path/to/module.so   // load module

bind ip [ip ...]                // bind to ip
protected-mode yes              // only allow local connection
port 6739                       // specify port number
```

## Snapshotting
save db to disk if the given number of seconds elapsed ant it surpassed the given number of write operations against the db

```
save seconds changes [seconds changes ...]
dbfilename dump.rdb         // the filename where to dump the db

```

## data

```
dir ./                      // the working directory
```

## replication

```
replicaof masterip masterport
masterauth master-password
masteruser username
```
## clients
```
maxclients 100000           // max number of clients
```

## memory management

```
maxmemory bytes
```





# redis-cli

```
redis-cli -h <hostname> -p <port> -a <password>
```
## list operation