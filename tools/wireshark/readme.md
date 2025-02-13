# wireshark



## Capture Filter syntax
```
[qualifier] [protocol] [direction] [type] [value]
```
### qualifier

type qualifiers say what kind of thing the id name or number refers to 
* host
* net
* port
* portrange

dir qualifiers specify a particular transfer direction to and/or from id
* src
* dest
* src or dest
* ra
* ta 
* addr1
* addr2
* addr3
* addr4


proto qualifiers restrict the match to particular protocol.
* ether
* fddi
* tr
* wlan
* ip
* ip6
* arp
* rarp
* decnet
* tcp
* udp

```
tcp port 8080
```