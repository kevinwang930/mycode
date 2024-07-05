function continue_fail() {
    if [ $? -eq 0 ]; then
    echo "command1 succeeded"
else
    echo "command1 failed"
fi
}


rm /Users/hwkf-marlsen-47932/code/git/spring/spring-framework/.gradle/workspace-id.txt

rm /Users/hwkf-marlsen-47932/code/git/spring/spring-boot/.gradle/workspace-id.txt

rm /Users/hwkf-marlsen-47932/code/git/kafka/.gradle/workspace-id.txt

rm /Users/hwkf-marlsen-47932/.gradle/caches/user-id.txt
