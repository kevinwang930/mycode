#!/bin/sh

code_path=~/code



exit_if_fail() {
    if [ $? -ne 0 ]; then
    echo "The previous command failed. Exiting the script."
    exit 1
    fi
}
# mkdir -p ~/code/git
# cd ~/code/git




# my
cd $code_path
exit_if_fail

# git clone git@gitee.com:kevinwang09/mydocs.git mydocs
git clone git@github.com:kevinwang930/myjava.git myjava

# git clone git@github.com:kevinwang930/myweb.git myweb
# git clone git@gitee.com:kevinwang09/myscala.git myscala
git clone git@github.com:kevinwang930/mycode.git 
# git clone git@gitee.com:kevinwang09/mypython.git mypython
git clone git@github.com:kevinwang930/kevinwang930.github.io.git blog



mkdir -p $code_path/git
cd $code_path/git
exit_if_fail



## spring 
git clone -b main --single-branch git@github.com:spring-projects/spring-framework.git spring-framework
git clone -b main --single-branch git@github.com:spring-projects/spring-boot.git spring-boot
git clone -b master --single-branch git@github.com:mybatis/mybatis-3.git mybatis3
git clone -b master --single-branch git@github.com:mybatis/spring.git mybatis-spring
git clone -b master --single-branch git@github.com:alibaba/nacos.git nacos
git clone git@github.com:baomidou/dynamic-datasource.git
git clone git@github.com:alibaba/druid.git
git clone git@github.com:spring-projects/spring-security.git spring-security
git clone git@github.com:jakartaee/servlet.git servlet
git clone git@github.com:apache/shiro.git shiro


## spring cloud
git clone git@github.com:spring-cloud/spring-cloud-gateway.git
git clone git@github.com:spring-cloud/spring-cloud-openfeign.git
git clone git@github.com:spring-cloud/spring-cloud-kubernetes.git
git clone git@github.com:spring-cloud/spring-cloud-commons.git
git clone git@github.com:spring-cloud/spring-cloud-build.git
git clone git@github.com:alibaba/spring-cloud-alibaba.git

# java
cd $code_path/git
exit_if_fail
git clone -b master --single-branch git@github.com:openjdk/jdk.git jdk
# git clone git@github.com:apache/httpcomponents-client.git httpcomponents-client
git clone git@github.com:apache/logging-log4j2.git logging-log4j2
# git clone git@github.com:apache/calcite-avatica.git calcite-avatica
# git clone git@github.com:apache/calcite.git calcite
# git clone git@github.com:MariaDB/server.git mariadb_server
git clone -b trunk --single-branch git@github.com:mysql/mysql-server.git mysql
# git clone git@github.com:apache/spark.git spark
# git clone git@github.com:apache/flink.git flink
# git clone git@github.com:apache/hadoop.git hadoop
git clone -b trunk --single-branch git@github.com:apache/kafka.git kafka
git clone -b main --single-branch git@github.com:apache/tomcat.git tomcat
git clone -b main --single-branch git@github.com:elastic/elasticsearch.git elasticsearch
git clone git@github.com:elastic/elasticsearch-java.git
git clone -b main --single-branch git@github.com:apache/lucene.git lucene


# golang
cd $code_path/git
exit_if_fail
git clone -b master --single-branch git@github.com:golang/go.git go

