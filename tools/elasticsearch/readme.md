# elastic

* install 
    ```
    curl -O https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.15.0-darwin-aarch64.tar.gz
    tar -xzf elasticsearch-8.15.0-darwin-aarch64.tar.gz
    cd elasticsearch-8.15.0/ 
    ```

```
./bin/elasticsearch   start
./bin/elasticsearch-users useradd root -p 123456 -r superuser
```
# kibana

* start
    ```
    ./bin/kibana
    ```
