echo $(alternatives --display java_sdk_1.8.0 | awk 'NR==3 {print $1}')
echo `alternatives --display java_sdk_1.8.0 | awk 'NR==3 {print $1}'`