# Data Type

## Numeric

1. int      4 bytes     
2. bigint   8 bytes

## date time
1. date             3 bytes     in 'YYYY-MM-DD' format
2. datetime         5 bytes + fractional     in 'YYYY-MM-DD hh:mm:ss' format
3. timestamp        4 bytes + fractional

## BLOB And TEXT
A `BLOB` is a binary large object that can hold a variable amount of data.
`BLOB` values are treated as binary strings(byte strings). They have the `binary` character and collation.
`TEXT` values are treated as nonbinary strings(character strings). They have a character set other than `binary`.



# Character set
A character set is a set of symbols and encodings.


MySQL Server supports multiple character sets. Available character set can be displayed using 
1. `INFORMATION_SCHEMA`.`CHARACTER_SET`
2. show character set


## Collation
A collation is a set of rules for comparing characters in a character set.
A given character set always has at least one collation. to list the collations for a character set, use 
1. `INFORMATION_SCHEMA`.`COLLATIONS`
2. show collation

Collation names start with the name of the character set with which they are associated, generally followed by one or more suffixes indicating other collation characteristics.

## Unicode Collation Algorithm

## Collation pad attribute
how collation treat spaces at the end of string

## utf8mb4 
A utf-8 encoding of the unicode character set using one to four bytes per character.

the default collation is `utf8mb4_0900_ai_ci`
    1. 0900 means unicode collation algorithm uca 9.0
    2. ai means accent insensitive
    3. ci means cas insensitive

## Character set specification
character set and collation can be set in database , table and column level.

get current character set and collation.
```
SELECT DEFAULT_CHARACTER_SET_NAME, DEFAULT_COLLATION_NAME
FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'db_name';
```


# configration

my.cnf
```
[client]
default-character-set=utf8mb4

[mysqld]
collation-server = utf8mb4_0900_ai_ci
init-connect='SET NAMES utf8mb4'
character-set-server = utf8mb4
default_storage_engine=InnoDB


## general_log
 general_log=1
 general_log_file = general.log

## slow query log
slow_query_log = 1
long_query_time = 0
log_output = TABLE
min_examined_row_limit=0    
```

# index

## Full-text

`InnoDB` full-text indexes have an inverted index design. Inverted indexes store a list of words, and for each word, a list of documents that the word appears in. To support proximity search, position information for each word is also stored as a byte offset.

full-text search use special syntax 
```
select name from items where Match(name) Against("baby")
```



# command line

## mysql

```
mysql -h [host] -P [port] -p[password]
```




