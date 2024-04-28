# network status

# -a both listening and non-listening sockets
# -n numeric show numerical addresses  host, port or usernames
# -p show the pid and name of program to which each socket belongs
# -t tcp connection, -u udp connection, -l listening

# display the program which use certain ports
netstat -anp | egrep ":22[[:space:]]+"

netstat -tunlp | grep 7890




