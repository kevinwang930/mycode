# create separate user
useradd hadoop
passwd hadoop 123456
ssh-keygen -t rsa
cat /home/hadoop/.ssh/id_rsa.pub
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 640 ~/.ssh/authorized_keys

mkdir -p ~/hadoopdata/hdfs/namenode
mkdir -p ~/hadoopdata/hdfs/datanode
code $HADOOP_HOME/etc/hadoop/core-site.xml