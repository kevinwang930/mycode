# install

```
bash -c "java -XshowSettings:properties -version |& grep -Po '(?<=java.home = |java.home=)(.*)'"
export INSTALL4J_JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre
sh bin/nexus  start
sh bin/next run
sh bin/nexus stop
```



# config




