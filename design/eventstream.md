# event stream

in event stream one biggest problem is connection with client.

partition of client, partition of consumer, and kafka topics need to be same rule.


```plantuml

top to bottom direction
actor user
actor user1
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
    
}
package consumer1 {
    rectangle kafkaConsumer1
    rectangle sse1   
}
database db

sse --> user: instant push
sse1 --> user1: instant push
like --> kafka: produce
follow --> kafka: produce
kafka --> kafkaConsumer: consume
kafka --> kafkaConsumer1: consume
kafkaConsumer --> db: cache
kafkaConsumer1 --> db: cache
kafkaConsumer --> sse
kafkaConsumer1 --> sse1
user -up-> db: fetch
user1 -up-> db: fetch

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



