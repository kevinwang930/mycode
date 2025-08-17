# image
docker pull apache/rocketmq:latest
# run 
## network
docker network create rocketmq

## Start NameServer
docker run -d --name rmqnamesrv -p 9876:9876 --network rocketmq apache/rocketmq:latest sh mqnamesrv

## Verify if NameServer started successfully
docker logs -f rmqnamesrv

## Start broker
docker run -d \
--name rmqbroker \
--network rocketmq \
-p 10912:10912 -p 10911:10911 -p 10909:10909 \
-p 8082:8080 -p 8081:8081 \
-e "NAMESRV_ADDR=rmqnamesrv:9876" \
-v ./broker.conf:/home/rocketmq/rocketmq-latest/conf/broker.conf \
apache/rocketmq:latest sh mqbroker --enable-proxy \
-c /home/rocketmq/rocketmq-latest/conf/broker.conf


# Verify if Broker started successfully
docker exec -it rmqbroker bash -c "tail -n 10 /home/rocketmq/logs/rocketmqlogs/proxy.log"


# Reference
https://rocketmq.apache.org/docs/quickStart/02quickstartWithDocker/