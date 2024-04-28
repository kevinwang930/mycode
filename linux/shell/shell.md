# what is shell

## what is UNIX
Computer parts can be grouped into 
1. input
2. output
3. storage
4. compute
5. networking
6. misc


Kernel is a program that abstracts over different hardware, allowing the same software to run on different computers.

UserSpace is the set of programs that come bundled with an os kernel, which allow user to perform tasks.

Shell is the outermost layer of an operating system; it let user run userspace programs, which in turn let a user interact with computer's hardware

Operating System is the combintion of a kernel, a set of userspace programs, and a shell.

Shell can be graphical or text based.

# I/O operation

In linux everything is a file
Standard Input(/dev/stdin) is file from which program reads its input
Standard Output(dev/stdout) is file to which program writes its output
Standard Error(/dev/stderr) is file to which program writes error messages

| Operator | File             | Overwrite? |
| -------- | ---------------- | ---------- |
| <        | /dev/stdin       |            |
| >        | /dev/stdout      | overwrite  |
| >>       | /dev/stdout      | Append     |
| 2>       | /dev/stderr      | Overwrite  |
| 2>>      | /dev/stderr      | Append     |
| &>       | stdout && stderr | Overwrit |

# Env variable
Environment variable is a configuraton value that's set globally by a program, which applies to itself and any other programs it runs.

env command to show all envs

# pipes
pipe is a direc connection between the output of one program and the input of another. It can be set up using | operator, which connects stdout of whatever is on left with stdin of whatever is on right.

```
env | wc -l 
```