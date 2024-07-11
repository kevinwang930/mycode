# Role Based Access Control 

Restrict network Access based on the roles of individual users

```plantuml
left to right direction
rectangle user {

}

rectangle role {
    actor administrator
    actor memeber
    actor guest
}
rectangle permissions {
    rectangle memberService
    rectangle commonService
    rectangle administration
}

user --> guest
user --> memeber
user --> administrator

administrator --> commonService
administrator --> memberService
administrator --> administration

memeber --> commonService
memeber --> memberService

guest --> commonService

```

## Structure and Implementation
Control    Central control 
* Role management


Operation Service    used by operations
* User
Auth Service         Business Auth Service
* User Role Assignment
* User Role Authentication



```plantuml
left to right direction
rectangle control

rectangle Business {

rectangle frontend
    rectangle Auth[
    Auth logic
    ]
    rectangle backend
}
actor user
user --> frontend
frontend --> Auth: login
Auth --> backend: roles query
control -right-> backend : roles control
```




