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
```plantuml
left to right direction

actor user

rectangle role

rectangle permissions

user --> role
role --> permissions


```




