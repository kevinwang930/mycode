stopProcess() {
    systemctl stop clash-core-service
    tmp=`ps -ef | grep cfw | grep -v grep | awk '{print $2}'`
    echo ${tmp}
    for id in $tmp
    do
    kill -9 $id
    echo "killed $id"
    done
}

stopProcess