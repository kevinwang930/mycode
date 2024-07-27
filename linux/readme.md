# file descriptor

In Unix and Unix-like os, a file descriptor (FD) is a process-unique identifier for a file or other I/O resource, such as pipe or network socket.


##  monitor and tune

Kernel parameter fs.file-max sets the system-wide parameter
```
sysctl fs.file-max
```
`/proc/sys/fs` can be used to tune and monitor miscellaneous and general things in the operation of Linux Kernel
`file-max` maximum number of file handlers the linux kernel will allocate
`file-nr`  number of allocated file handlers, number of allocated but unused file handlers, maximum number of file handlers
`nr_open`  maximum number of file-handlers a process can allocate.
`ls -1 /proc/${PID}/fd | wc -l`  count the file descriptor a process possess.

```
cat /proc/sys/fs/file-max
cat /proc/sys/fs/file-nr
cat /proc/sys/fs/nr_open
```
`ulimit -n` soft limit the file descriptors a process may have.
`ls -p {pId} | wc -l` can also be used to count the file descriptors but not accurate.


