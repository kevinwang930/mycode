# 初始化

## 设置

log.dirs=/data/kafka/kraft-combined-logs


## 格式化存储

linux
```
kafka-storage.sh random-uuid
kafka-storage.sh format -t vrrEH4ApTnWLcuqu2_aF8g -c /data/kafka/config/kraft/server.properties
```



mac
```
kafka-storage random-uuid
kafka-storage format -t czAwogGRQx2ivhvL2nUDaw -c /opt/homebrew/etc/kafka/kraft/server.properties
```


## 启动

kafka-server-start.sh -daemon /data/kafka/config/kraft/server.properties

kafka-server-start.sh  /data/kafka/config/kraft/server.properties

## 测试kafka是否正常工作


linux 
```
/data/kafka/bin/kafka-topics.sh --create --topic quickstart-events --bootstrap-server localhost:9092

echo "this is a test" | /data/kafka/bin/kafka-console-producer.sh --topic quickstart-events --bootstrap-server localhost:9092 

/data/kafka/bin/kafka-console-consumer.sh --topic quickstart-events --from-beginning --bootstrap-server localhost:9092
```

mac

```
kafka-topics --create --topic quickstart-events --bootstrap-server localhost:9092

echo "this is a test" | kafka-console-producer --topic quickstart-events --bootstrap-server localhost:9092 

kafka-console-consumer --topic quickstart-events --from-beginning --bootstrap-server localhost:9092
```


# server running status log



# recover from checkpoint

export KAFKA_OPTS="-Dkraft.cluster.id=VMz1Q97uTzidzBm6k_BXPg -Dkraft.snapshot.file=/tmp/kraft-combined-logs/__cluster_metadata-0/00000000000006843739-0000000009.checkpoint"
kafka-server-start.sh  /data/kafka/config/kraft/server.properties


