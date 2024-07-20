# cloud design




```plantuml

actor client

actor admin

rectangle gateway

rectangle sys {
    rectangle "sys-auth" as sysauth
    rectangle "sys-api" as sysapi
    rectangle "sys-system"  as syssystem {
        rectangle "sys-endpoint" as sendpoint
        rectangle "sys-security" as ssecurity
        ssecurity --> sendpoint
    }
}


rectangle site {
    rectangle "site-auth" as siteauth
    rectangle "site-api" as siteapi
    rectangle "site-system"  as sitesystem {
        rectangle "site-endpoint" as siteendpoint
        rectangle "site-security" as sitesecurity
        sitesecurity --> siteendpoint
    }
}

admin --> gateway
gateway --> sysauth: 登陆
sysauth--> sysapi


client --> gateway
gateway --> siteauth: 登陆
siteauth--> siteapi
gateway --> sitesecurity 
gateway --> ssecurity 
siteapi -up-> gateway: feign
sysapi -up-> gateway: feign

```


```plantuml
title 登陆过程



front --> TokenController: login



box "Auth Service"
participant TokenController
end box
box "System Service"
participant SysUserController
end box
TokenController --> SysUserController: info
```

```plantuml
title api请求过程
left to right direction
rectangle gateway {
    rectangle AuthFilter
}

rectangle service {
    rectangle security
    rectangle endpoint
}

rectangle redis

request --> AuthFilter
AuthFilter --> redis:  token
AuthFilter --> security
security -right-> redis :  permission
security --> endpoint
```

