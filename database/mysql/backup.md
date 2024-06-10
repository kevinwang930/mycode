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



# mysqlbinlog

mysqlbinlog --stop-datetime="2024-06-10 11:00:00"  \
binlog.000001 \
binlog.000002 \
binlog.000003 \
binlog.000004 \
binlog.000005 \
binlog.000006 \
binlog.000007 \
binlog.000008 \
binlog.000009 \
binlog.000010 \
binlog.000011 \
binlog.000012 \
binlog.000013 \
binlog.000014 \
binlog.000015 \
binlog.000016 \
binlog.000017 \
binlog.000018 \
binlog.000019 \
binlog.000020 \
binlog.000021 \
binlog.000022 \
binlog.000023 \
binlog.000024 \
binlog.000025 \
binlog.000026 \
binlog.000027 \
binlog.000028 \
binlog.000029 \
binlog.000030 \
binlog.000031 \
binlog.000032 \
binlog.000033 \
binlog.000034 \
binlog.000035 \
binlog.000036 \
binlog.000037 \
binlog.000038 \
binlog.000039 \
binlog.000040 \
> recover.binlog


# master slave setting

CHANGE MASTER TO
    MASTER_HOST='119.8.41.53',
    MASTER_USER='replicator',
    MASTER_PASSWORD='123456',
    MASTER_PORT=3309,
    MASTER_LOG_FILE='binlog.000001',
    MASTER_LOG_POS=126;

START SLAVE UNTIL MASTER_LOG_FILE = 'binlog.000040', MASTER_LOG_POS = 3939209;


