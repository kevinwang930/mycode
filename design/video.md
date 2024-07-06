# video

```plantuml

VideoService --> Segmenter: submit
VideoService --> Transform: submit

VideoService --> MinioService: upload
```


