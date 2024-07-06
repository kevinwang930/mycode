# event stream


```plantuml

top to bottom direction
actor user
queue kafka {
    rectangle topic1 
    rectangle topic2 
}
package producer1 {
    (follow)
}
package producer2 {
    (like)
}

package consumer {
    rectangle kafkaConsumer
    rectangle sse
    database db
}


sse --> user: instant push
like --> kafka: produce
follow --> kafka: produce
kafka --> kafkaConsumer: consume
kafkaConsumer --> db: cache
kafkaConsumer --> sse
user --> db: fetch

```

# event dispatcher


```plantuml

interface EventDispatcher {
    void start()
    void stop()
    SseEmitter sse(Long userId)

    subscirbe()
    dispatch(record)
}

class EventDispatcherImpl implements EventDispatcher {
    ConcurrentHashMap<Long, SseEmitter> emitterMap 
}


```



