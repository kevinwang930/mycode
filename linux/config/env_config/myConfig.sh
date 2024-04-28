
export JAVA_17_HOME=$(alternatives --display java_sdk_17 | awk 'NR==3 {print $1}')
export JAVA_21_HOME=$(alternatives --display java_sdk_21 | awk 'NR==3 {print $1}')
export JAVA_HOME=$JAVA_21_HOME
# pentaho setting
# export PENTAHO_JAVA_HOME=$JAVA_8_HOME
# export PENTAHO_HOME=/code/BI/data-integration

# hadoop setting
# export HADOOP_HOME=/code/BI/hadoop-3.3.1
# export HADOOP_INSTALL=$HADOOP_HOME
# export HADOOP_MAPRED_HOME=$HADOOP_HOME
# export HADOOP_COMMON_HOME=$HADOOP_HOME
# export HADOOP_HDFS_HOME=$HADOOP_HOME
# export HADOOP_YARN_HOME=$HADOOP_HOME
# export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
# export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"


# hive setting
# export HIVE_HOME=/code/BI/apache-hive-3.1.2-bin


# spark setting
# export SPARK_HOME=/code/BI/spark-3.2.0-bin-hadoop3.2


# path setting
# export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin:$HIVE_HOME/bin
# export PYTHONPATH=$(ZIPS=("$SPARK_HOME"/python/lib/*.zip); IFS=:; echo "${ZIPS[*]}"):$PYTHONPATH






