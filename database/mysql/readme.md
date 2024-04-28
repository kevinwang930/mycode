# Data Type

## Numeric

1. int      4 bytes     
2. bigint   8 bytes

## date time
1. date             3 bytes     in 'YYYY-MM-DD' format
2. datetime         5 bytes + fractional     in 'YYYY-MM-DD hh:mm:ss' format
3. timestamp        4 bytes + fractional

# Character set

A character set is a set of symbols and encodings.


MySQL Server supports multiple character sets. Available character set can be displayed using 
1. `INFORMATION_SCHEMA`.`CHARACTER_SET`
2. show character set


# Collation
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

# Character set specification
character set and collation can be set in database , table and column level.

get current character set and collation.
```
SELECT DEFAULT_CHARACTER_SET_NAME, DEFAULT_COLLATION_NAME
FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'db_name';
```


# mysql default

my.cnf
```
[client]
default-character-set=utf8mb4

[mysqld]
collation-server = utf8mb4_0900_ai_ci
init-connect='SET NAMES utf8mb4'
character-set-server = utf8mb4
default_storage_engine=InnoDB
```


