# Physical(Raw)

Physical backups consist of raw copies of the directories and files that store database contents.

physical backup methods are faster than logical because they involve only file copying without conversion

# Logical 

Logical backups save information represented as logical database structure(create databse, create table) and content(insert statements)

logical backup tools include 
1. mysqldump 
2. select ... into outfiles


# mysqldump



```
mysqldump [options] database [tables]
mysqldump [options] --databases db1 [db2,db3...]

options:
-d --no-data

options variables: (--variable-name=value)
1. host
2. port
3. user
4. password
5. result-file=dump.sql 

example:

mysqldump --no-data --result-file=dump.sql --user=root --password=barplus03582 --host=119.13.125.180 --port=3306 --databases bmw
```