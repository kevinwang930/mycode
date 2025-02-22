- [1. concept](#1-concept)
  - [1.1 sparkContext](#11-sparkcontext)


# 1. Overview
At a high level, every Spark application consists of a driver program that runs the user’s main function and executes various parallel operations on a cluster. 



# 1. concept

## 1.1 sparkContext


Main entry point of Spark functionality. A sparkContext represents the connection to a spark cluster, and can be used to create RDDs,accumulators and broadcast variables on that cluster.



```plantuml
class SparkContext {
  - _conf
  - _taskScheduler
  - dagScheduler
  - _listenerBus
}

class SparkConf

class TaskScheduler {
  start()
  stop()
  submitTasks()
}

class TaskSchedulerImpl {
  sc
  conf
  dagScheduler
  backend
  mapOutputTracker
}
class DAGScheduler {
  listenerBus
  taskScheduler
  eventProcessLoop
  handleJobSubmitted()
}
class LiveListenerBus {

}

class DAGSchedulerEventProcessLoop {
  dagScheduler
  onReceive(event)
}
SparkContext o-- SparkConf
SparkContext o-- TaskScheduler
SparkContext o-- DAGScheduler
SparkContext o-- LiveListenerBus
DAGScheduler o-left- LiveListenerBus
DAGScheduler o-right- TaskScheduler
DAGScheduler o-- DAGSchedulerEventProcessLoop
TaskScheduler o-- TaskSchedulerImpl
```

## 1.2 TaskScheduler
```plantuml

```

## 1.3 Block tracker

## 1.4 Shuffle tracker

## 1.5 Block manager

# 2. RDD
operations:
1. transformations create new dataset from existing one
2. actions return a value to the driver program

# 3. DATASET
```plantuml
class SparkSession {
  sparkContext
}

class DataFrameReader {
  source
  extraOptions
}

```
## 3.1 Structured Streaming




/usr/lib/jvm/java-11/bin/java -javaagent:/home/kw/.local/share/JetBrains/Toolbox/apps/intellij-idea-ultimate/lib/idea_rt.jar=45389:/home/kw/.local/share/JetBrains/Toolbox/apps/intellij-idea-ultimate/bin -Dfile.encoding=UTF-8 -classpath /code/myscala/mySpark/target/scala-2.12/classes:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/aopalliance/aopalliance/1.0/aopalliance-1.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/ch/qos/reload4j/reload4j/1.2.22/reload4j-1.2.22.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/clearspring/analytics/stream/2.9.6/stream-2.9.6.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/esotericsoftware/kryo-shaded/4.0.2/kryo-shaded-4.0.2.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/esotericsoftware/minlog/1.3.0/minlog-1.3.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-annotations/2.15.2/jackson-annotations-2.15.2.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-core/2.15.2/jackson-core-2.15.2.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-databind/2.15.2/jackson-databind-2.15.2.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/fasterxml/jackson/datatype/jackson-datatype-jsr310/2.15.1/jackson-datatype-jsr310-2.15.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/fasterxml/jackson/jaxrs/jackson-jaxrs-base/2.12.7/jackson-jaxrs-base-2.12.7.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/fasterxml/jackson/jaxrs/jackson-jaxrs-json-provider/2.12.7/jackson-jaxrs-json-provider-2.12.7.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/fasterxml/jackson/module/jackson-module-jaxb-annotations/2.12.7/jackson-module-jaxb-annotations-2.12.7.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/fasterxml/jackson/module/jackson-module-scala_2.12/2.15.2/jackson-module-scala_2.12-2.15.2.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/fasterxml/woodstox/woodstox-core/5.4.0/woodstox-core-5.4.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/github/luben/zstd-jni/1.5.5-4/zstd-jni-1.5.5-4.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/github/pjfanning/jersey-json/1.20/jersey-json-1.20.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/github/stephenc/jcip/jcip-annotations/1.0-1/jcip-annotations-1.0-1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/google/code/findbugs/jsr305/3.0.2/jsr305-3.0.2.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/google/code/gson/gson/2.10.1/gson-2.10.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/google/crypto/tink/tink/1.9.0/tink-1.9.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/google/errorprone/error_prone_annotations/2.2.0/error_prone_annotations-2.2.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/google/flatbuffers/flatbuffers-java/1.12.0/flatbuffers-java-1.12.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/google/guava/failureaccess/1.0.1/failureaccess-1.0.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/google/guava/guava/27.0.1-jre/guava-27.0.1-jre.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/google/guava/listenablefuture/9999.0-empty-to-avoid-conflict-with-guava/listenablefuture-9999.0-empty-to-avoid-conflict-with-guava.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/google/inject/guice/4.0/guice-4.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/google/j2objc/j2objc-annotations/1.1/j2objc-annotations-1.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/google/protobuf/protobuf-java/3.21.9/protobuf-java-3.21.9.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/google/re2j/re2j/1.1/re2j-1.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.2.0/mysql-connector-j-8.2.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/nimbusds/nimbus-jose-jwt/9.8.1/nimbus-jose-jwt-9.8.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/ning/compress-lzf/1.1.2/compress-lzf-1.1.2.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/squareup/okhttp3/okhttp/4.9.3/okhttp-4.9.3.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/squareup/okio/okio/2.8.0/okio-2.8.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/sun/jersey/contribs/jersey-guice/1.19.4/jersey-guice-1.19.4.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/sun/jersey/jersey-client/1.19.4/jersey-client-1.19.4.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/sun/jersey/jersey-core/1.19.4/jersey-core-1.19.4.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/sun/jersey/jersey-server/1.19.4/jersey-server-1.19.4.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/sun/jersey/jersey-servlet/1.19.4/jersey-servlet-1.19.4.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/sun/xml/bind/jaxb-impl/2.2.3-1/jaxb-impl-2.2.3-1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/thoughtworks/paranamer/paranamer/2.8/paranamer-2.8.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/twitter/chill-java/0.10.0/chill-java-0.10.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/twitter/chill_2.12/0.10.0/chill_2.12-0.10.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/com/univocity/univocity-parsers/2.9.1/univocity-parsers-2.9.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/commons-beanutils/commons-beanutils/1.9.4/commons-beanutils-1.9.4.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/commons-cli/commons-cli/1.2/commons-cli-1.2.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/commons-codec/commons-codec/1.16.0/commons-codec-1.16.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/commons-collections/commons-collections/3.2.2/commons-collections-3.2.2.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/commons-io/commons-io/2.13.0/commons-io-2.13.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/commons-logging/commons-logging/1.2/commons-logging-1.2.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/commons-net/commons-net/3.9.0/commons-net-3.9.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/dnsjava/dnsjava/2.1.7/dnsjava-2.1.7.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/io/airlift/aircompressor/0.25/aircompressor-0.25.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/io/dropwizard/metrics/metrics-core/4.2.19/metrics-core-4.2.19.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/io/dropwizard/metrics/metrics-graphite/4.2.19/metrics-graphite-4.2.19.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/io/dropwizard/metrics/metrics-jmx/4.2.19/metrics-jmx-4.2.19.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/io/dropwizard/metrics/metrics-json/4.2.19/metrics-json-4.2.19.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/io/dropwizard/metrics/metrics-jvm/4.2.19/metrics-jvm-4.2.19.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/io/netty/netty-all/4.1.96.Final/netty-all-4.1.96.Final.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/io/netty/netty-buffer/4.1.96.Final/netty-buffer-4.1.96.Final.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/io/netty/netty-codec-http2/4.1.96.Final/netty-codec-http2-4.1.96.Final.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/io/netty/netty-codec-http/4.1.96.Final/netty-codec-http-4.1.96.Final.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/io/netty/netty-codec-socks/4.1.96.Final/netty-codec-socks-4.1.96.Final.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/io/netty/netty-codec/4.1.96.Final/netty-codec-4.1.96.Final.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/io/netty/netty-common/4.1.96.Final/netty-common-4.1.96.Final.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/io/netty/netty-handler-proxy/4.1.96.Final/netty-handler-proxy-4.1.96.Final.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/io/netty/netty-handler/4.1.96.Final/netty-handler-4.1.96.Final.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/io/netty/netty-resolver/4.1.96.Final/netty-resolver-4.1.96.Final.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/io/netty/netty-transport-classes-epoll/4.1.96.Final/netty-transport-classes-epoll-4.1.96.Final.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/io/netty/netty-transport-classes-kqueue/4.1.96.Final/netty-transport-classes-kqueue-4.1.96.Final.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/io/netty/netty-transport-native-epoll/4.1.96.Final/netty-transport-native-epoll-4.1.96.Final.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/io/netty/netty-transport-native-epoll/4.1.96.Final/netty-transport-native-epoll-4.1.96.Final-linux-aarch_64.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/io/netty/netty-transport-native-epoll/4.1.96.Final/netty-transport-native-epoll-4.1.96.Final-linux-x86_64.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/io/netty/netty-transport-native-kqueue/4.1.96.Final/netty-transport-native-kqueue-4.1.96.Final-osx-aarch_64.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/io/netty/netty-transport-native-kqueue/4.1.96.Final/netty-transport-native-kqueue-4.1.96.Final-osx-x86_64.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/io/netty/netty-transport-native-unix-common/4.1.96.Final/netty-transport-native-unix-common-4.1.96.Final.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/io/netty/netty-transport/4.1.96.Final/netty-transport-4.1.96.Final.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/jakarta/activation/jakarta.activation-api/1.2.1/jakarta.activation-api-1.2.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/jakarta/annotation/jakarta.annotation-api/1.3.5/jakarta.annotation-api-1.3.5.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/jakarta/servlet/jakarta.servlet-api/4.0.3/jakarta.servlet-api-4.0.3.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/jakarta/validation/jakarta.validation-api/2.0.2/jakarta.validation-api-2.0.2.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/jakarta/ws/rs/jakarta.ws.rs-api/2.1.6/jakarta.ws.rs-api-2.1.6.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/jakarta/xml/bind/jakarta.xml.bind-api/2.3.2/jakarta.xml.bind-api-2.3.2.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/javax/activation/activation/1.1.1/activation-1.1.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/javax/inject/javax.inject/1/javax.inject-1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/javax/servlet/jsp/jsp-api/2.1/jsp-api-2.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/javax/servlet/javax.servlet-api/3.1.0/javax.servlet-api-3.1.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/javax/ws/rs/jsr311-api/1.1.1/jsr311-api-1.1.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/javax/xml/bind/jaxb-api/2.2.11/jaxb-api-2.2.11.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/joda-time/joda-time/2.12.5/joda-time-2.12.5.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/net/razorvine/pickle/1.3/pickle-1.3.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/net/sf/py4j/py4j/0.10.9.7/py4j-0.10.9.7.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/antlr/antlr4-runtime/4.9.3/antlr4-runtime-4.9.3.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/arrow/arrow-format/12.0.1/arrow-format-12.0.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/arrow/arrow-memory-core/12.0.1/arrow-memory-core-12.0.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/arrow/arrow-memory-netty/12.0.1/arrow-memory-netty-12.0.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/arrow/arrow-vector/12.0.1/arrow-vector-12.0.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/avro/avro-ipc/1.11.2/avro-ipc-1.11.2.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/avro/avro-mapred/1.11.2/avro-mapred-1.11.2.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/avro/avro/1.11.2/avro-1.11.2.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/commons/commons-collections4/4.4/commons-collections4-4.4.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/commons/commons-compress/1.23.0/commons-compress-1.23.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/commons/commons-configuration2/2.8.0/commons-configuration2-2.8.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/commons/commons-crypto/1.1.0/commons-crypto-1.1.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/commons/commons-lang3/3.12.0/commons-lang3-3.12.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/commons/commons-math3/3.6.1/commons-math3-3.6.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/commons/commons-text/1.10.0/commons-text-1.10.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/curator/curator-client/5.2.0/curator-client-5.2.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/curator/curator-framework/5.2.0/curator-framework-5.2.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/curator/curator-recipes/5.2.0/curator-recipes-5.2.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/datasketches/datasketches-java/3.3.0/datasketches-java-3.3.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/datasketches/datasketches-memory/2.1.0/datasketches-memory-2.1.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/hadoop/thirdparty/hadoop-shaded-guava/1.1.1/hadoop-shaded-guava-1.1.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/hadoop/thirdparty/hadoop-shaded-protobuf_3_7/1.1.1/hadoop-shaded-protobuf_3_7-1.1.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/hadoop/hadoop-annotations/3.3.6/hadoop-annotations-3.3.6.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/hadoop/hadoop-auth/3.3.6/hadoop-auth-3.3.6.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/hadoop/hadoop-client-api/3.3.4/hadoop-client-api-3.3.4.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/hadoop/hadoop-client-runtime/3.3.4/hadoop-client-runtime-3.3.4.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/hadoop/hadoop-client/3.3.6/hadoop-client-3.3.6.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/hadoop/hadoop-common/3.3.6/hadoop-common-3.3.6.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/hadoop/hadoop-hdfs-client/3.3.6/hadoop-hdfs-client-3.3.6.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/hadoop/hadoop-mapreduce-client-common/3.3.6/hadoop-mapreduce-client-common-3.3.6.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/hadoop/hadoop-mapreduce-client-core/3.3.6/hadoop-mapreduce-client-core-3.3.6.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/hadoop/hadoop-mapreduce-client-jobclient/3.3.6/hadoop-mapreduce-client-jobclient-3.3.6.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/hadoop/hadoop-yarn-api/3.3.6/hadoop-yarn-api-3.3.6.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/hadoop/hadoop-yarn-client/3.3.6/hadoop-yarn-client-3.3.6.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/hadoop/hadoop-yarn-common/3.3.6/hadoop-yarn-common-3.3.6.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/hive/hive-storage-api/2.8.1/hive-storage-api-2.8.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/httpcomponents/httpclient/4.5.13/httpclient-4.5.13.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/httpcomponents/httpcore/4.4.13/httpcore-4.4.13.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/ivy/ivy/2.5.1/ivy-2.5.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/kerby/kerb-admin/1.0.1/kerb-admin-1.0.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/kerby/kerb-client/1.0.1/kerb-client-1.0.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/kerby/kerb-common/1.0.1/kerb-common-1.0.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/kerby/kerb-core/1.0.1/kerb-core-1.0.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/kerby/kerb-crypto/1.0.1/kerb-crypto-1.0.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/kerby/kerb-identity/1.0.1/kerb-identity-1.0.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/kerby/kerb-server/1.0.1/kerb-server-1.0.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/kerby/kerb-simplekdc/1.0.1/kerb-simplekdc-1.0.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/kerby/kerb-util/1.0.1/kerb-util-1.0.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/kerby/kerby-asn1/1.0.1/kerby-asn1-1.0.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/kerby/kerby-config/1.0.1/kerby-config-1.0.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/kerby/kerby-pkix/1.0.1/kerby-pkix-1.0.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/kerby/kerby-util/1.0.1/kerby-util-1.0.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/kerby/kerby-xdr/1.0.1/kerby-xdr-1.0.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/kerby/token-provider/1.0.1/token-provider-1.0.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/logging/log4j/log4j-1.2-api/2.20.0/log4j-1.2-api-2.20.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/logging/log4j/log4j-api/2.20.0/log4j-api-2.20.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/logging/log4j/log4j-core/2.20.0/log4j-core-2.20.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/logging/log4j/log4j-slf4j2-impl/2.20.0/log4j-slf4j2-impl-2.20.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/orc/orc-core/1.9.1/orc-core-1.9.1-shaded-protobuf.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/orc/orc-mapreduce/1.9.1/orc-mapreduce-1.9.1-shaded-protobuf.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/orc/orc-shims/1.9.1/orc-shims-1.9.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/parquet/parquet-column/1.13.1/parquet-column-1.13.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/parquet/parquet-common/1.13.1/parquet-common-1.13.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/parquet/parquet-encoding/1.13.1/parquet-encoding-1.13.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/parquet/parquet-format-structures/1.13.1/parquet-format-structures-1.13.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/parquet/parquet-hadoop/1.13.1/parquet-hadoop-1.13.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/parquet/parquet-jackson/1.13.1/parquet-jackson-1.13.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/spark/spark-catalyst_2.12/3.5.0/spark-catalyst_2.12-3.5.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/spark/spark-common-utils_2.12/3.5.0/spark-common-utils_2.12-3.5.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/spark/spark-core_2.12/3.5.0/spark-core_2.12-3.5.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/spark/spark-kvstore_2.12/3.5.0/spark-kvstore_2.12-3.5.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/spark/spark-launcher_2.12/3.5.0/spark-launcher_2.12-3.5.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/spark/spark-network-common_2.12/3.5.0/spark-network-common_2.12-3.5.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/spark/spark-network-shuffle_2.12/3.5.0/spark-network-shuffle_2.12-3.5.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/spark/spark-sketch_2.12/3.5.0/spark-sketch_2.12-3.5.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/spark/spark-sql-api_2.12/3.5.0/spark-sql-api_2.12-3.5.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/spark/spark-sql_2.12/3.5.0/spark-sql_2.12-3.5.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/spark/spark-tags_2.12/3.5.0/spark-tags_2.12-3.5.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/spark/spark-unsafe_2.12/3.5.0/spark-unsafe_2.12-3.5.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/xbean/xbean-asm9-shaded/4.23/xbean-asm9-shaded-4.23.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/yetus/audience-annotations/0.13.0/audience-annotations-0.13.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/zookeeper/zookeeper-jute/3.6.3/zookeeper-jute-3.6.3.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/zookeeper/zookeeper/3.6.3/zookeeper-3.6.3.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/checkerframework/checker-qual/2.5.2/checker-qual-2.5.2.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/codehaus/janino/commons-compiler/3.1.9/commons-compiler-3.1.9.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/codehaus/janino/janino/3.1.9/janino-3.1.9.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/codehaus/jettison/jettison/1.1/jettison-1.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/codehaus/mojo/animal-sniffer-annotations/1.17/animal-sniffer-annotations-1.17.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/codehaus/woodstox/stax2-api/4.2.1/stax2-api-4.2.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/eclipse/jetty/websocket/websocket-api/9.4.51.v20230217/websocket-api-9.4.51.v20230217.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/eclipse/jetty/websocket/websocket-client/9.4.51.v20230217/websocket-client-9.4.51.v20230217.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/eclipse/jetty/websocket/websocket-common/9.4.51.v20230217/websocket-common-9.4.51.v20230217.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/eclipse/jetty/jetty-client/9.4.51.v20230217/jetty-client-9.4.51.v20230217.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/eclipse/jetty/jetty-http/9.4.51.v20230217/jetty-http-9.4.51.v20230217.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/eclipse/jetty/jetty-io/9.4.51.v20230217/jetty-io-9.4.51.v20230217.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/eclipse/jetty/jetty-security/9.4.51.v20230217/jetty-security-9.4.51.v20230217.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/eclipse/jetty/jetty-servlet/9.4.51.v20230217/jetty-servlet-9.4.51.v20230217.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/eclipse/jetty/jetty-util-ajax/9.4.51.v20230217/jetty-util-ajax-9.4.51.v20230217.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/eclipse/jetty/jetty-util/9.4.51.v20230217/jetty-util-9.4.51.v20230217.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/eclipse/jetty/jetty-webapp/9.4.51.v20230217/jetty-webapp-9.4.51.v20230217.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/eclipse/jetty/jetty-xml/9.4.51.v20230217/jetty-xml-9.4.51.v20230217.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/fusesource/leveldbjni/leveldbjni-all/1.8/leveldbjni-all-1.8.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/glassfish/hk2/external/aopalliance-repackaged/2.6.1/aopalliance-repackaged-2.6.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/glassfish/hk2/external/jakarta.inject/2.6.1/jakarta.inject-2.6.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/glassfish/hk2/hk2-api/2.6.1/hk2-api-2.6.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/glassfish/hk2/hk2-locator/2.6.1/hk2-locator-2.6.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/glassfish/hk2/hk2-utils/2.6.1/hk2-utils-2.6.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/glassfish/hk2/osgi-resource-locator/1.0.3/osgi-resource-locator-1.0.3.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/glassfish/jersey/containers/jersey-container-servlet-core/2.40/jersey-container-servlet-core-2.40.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/glassfish/jersey/containers/jersey-container-servlet/2.40/jersey-container-servlet-2.40.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/glassfish/jersey/core/jersey-client/2.40/jersey-client-2.40.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/glassfish/jersey/core/jersey-common/2.40/jersey-common-2.40.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/glassfish/jersey/core/jersey-server/2.40/jersey-server-2.40.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/glassfish/jersey/inject/jersey-hk2/2.40/jersey-hk2-2.40.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/javassist/javassist/3.29.2-GA/javassist-3.29.2-GA.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/jetbrains/kotlin/kotlin-stdlib-common/1.4.10/kotlin-stdlib-common-1.4.10.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/jetbrains/kotlin/kotlin-stdlib/1.4.10/kotlin-stdlib-1.4.10.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/jetbrains/annotations/17.0.0/annotations-17.0.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/jline/jline/3.9.0/jline-3.9.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/json4s/json4s-ast_2.12/3.7.0-M11/json4s-ast_2.12-3.7.0-M11.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/json4s/json4s-core_2.12/3.7.0-M11/json4s-core_2.12-3.7.0-M11.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/json4s/json4s-jackson_2.12/3.7.0-M11/json4s-jackson_2.12-3.7.0-M11.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/json4s/json4s-scalap_2.12/3.7.0-M11/json4s-scalap_2.12-3.7.0-M11.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/lz4/lz4-java/1.8.0/lz4-java-1.8.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/objenesis/objenesis/2.5.1/objenesis-2.5.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/roaringbitmap/RoaringBitmap/0.9.45/RoaringBitmap-0.9.45.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/roaringbitmap/shims/0.9.45/shims-0.9.45.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/rocksdb/rocksdbjni/8.3.2/rocksdbjni-8.3.2.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/scala-lang/modules/scala-parser-combinators_2.12/2.3.0/scala-parser-combinators_2.12-2.3.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/scala-lang/modules/scala-xml_2.12/2.1.0/scala-xml_2.12-2.1.0.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/scala-lang/scala-library/2.12.17/scala-library-2.12.17.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/scala-lang/scala-reflect/2.12.17/scala-reflect-2.12.17.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/slf4j/jcl-over-slf4j/2.0.7/jcl-over-slf4j-2.0.7.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/slf4j/jul-to-slf4j/2.0.7/jul-to-slf4j-2.0.7.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/slf4j/slf4j-api/2.0.7/slf4j-api-2.0.7.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/slf4j/slf4j-reload4j/1.7.36/slf4j-reload4j-1.7.36.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/threeten/threeten-extra/1.7.1/threeten-extra-1.7.1.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/tukaani/xz/1.9/xz-1.9.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/org/xerial/snappy/snappy-java/1.1.10.3/snappy-java-1.1.10.3.jar:/home/kw/.cache/coursier/v1/https/repo1.maven.org/maven2/oro/oro/2.0.8/oro-2.0.8.jar DataSetLearn