cat << 'EOF' > /etc/profile.d/spark.sh
#!/bin/sh
export SPARK_HOME=/opt/user/spark-3.5.0-bin-hadoop3-scala2.13
export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin
export LD_LIBRARY_PATH=$HADOOP_HOME/lib/native
EOF
