#!/bin/sh

code_path=~/code


git_clone() {
    git_repo=$1
    local_repo=$2
    if [ -d "$local_repo" ]; then
        echo "Directory $local_repo already exists."
        return -1 # die with error code 9999
    fi
    git clone "$git_repo" "$local_repo"
}
# mkdir -p ~/code/git
# cd ~/code/git
# git_clone git@github.com:apache/httpcomponents-client.git httpcomponents-client
# git_clone git@github.com:apache/logging-log4j2.git logging-log4j2
# git_clone git@github.com:apache/calcite-avatica.git calcite-avatica
# git_clone git@github.com:apache/calcite.git calcite
# git_clone git@github.com:MariaDB/server.git mariadb_server
# git_clone git@github.com:mysql/mysql-server.git mysql
# git_clone git@github.com:apache/spark.git spark
# git_clone git@github.com:apache/flink.git flink
# git_clone git@github.com:apache/hadoop.git hadoop
# git_clone git@github.com:apache/kafka.git kafka
# git_clone git@github.com:spring-projects/spring-framework.git spring-framework
# git_clone git@github.com:spring-projects/spring-boot.git spring-boot
# git_clone git@github.com:mybatis/mybatis-3.git mybatis3
# git_clone git@github.com:mybatis/spring.git mybatis-spring
# git_clone git@github.com:openjdk/jdk.git jdk
# git_clone git@github.com:golang/go.git go

cd $code_path

# git_clone git@gitee.com:kevinwang09/mydocs.git mydocs
git_clone git@github.com:kevinwang930/myjava.git myjava
# git_clone git@gitee.com:kevinwang09/myscala.git myscala
# git_clone git@github.com:kevinwang930/mycode.git mycode
# git_clone git@gitee.com:kevinwang09/mypython.git mypython
git_clone git@github.com:kevinwang930/kevinwang930.github.io.git blog
