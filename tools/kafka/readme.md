# 初始化


## 格式化存储

kafka-storage random-uuid

kafka-storage.sh format -t VMz1Q97uTzidzBm6k_BXPg -c /data/kafka/config/kraft/server.properties


## 启动

kafka-server-start.sh -daemon /data/kafka/config/kraft/server.properties

kafka-server-start.sh  /data/kafka/config/kraft/server.properties

## 测试启动命令

/data/kafka/bin/kafka-topics.sh --create --topic quickstart-events --bootstrap-server localhost:9092

echo "this is a test" | /data/kafka/bin/kafka-console-producer.sh --topic quickstart-events --bootstrap-server localhost:9092 

/data/kafka/bin/kafka-console-consumer.sh --topic quickstart-events --from-beginning --bootstrap-server localhost:9092


# 





