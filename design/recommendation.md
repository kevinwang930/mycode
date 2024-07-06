# Recommendation


```plantuml
left to right direction
actor user


package videoService {
    (api)

}

database db

user --> api

api --> db: get user rec info

api --> user: return recommendation

```