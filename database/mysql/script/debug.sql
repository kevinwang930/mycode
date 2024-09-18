SET SESSION debug='+d,skip_dd_table_access_check';


ALTER USER 'root'@'localhost' IDENTIFIED BY '';


create database `test`;
use `test`;


create table Person
(
    id   bigint auto_increment primary key,
    name varchar(255) not null
);


select * from mysql.tables;

select * from mysql.schemata;

select * from mysql.catalogs;

select * from mysql.tablespaces;

select * from mysql.indexes;
select * from mysql.tables where `name` = 'person';
select * from mysql.tables where id = 1;

select * from mysql.columns where table_id = 382;

select * from mysql.columns where `name` = 'DB_ROW_ID';

select * from mysql.columns where table_id = 1;

select * from mysql.innodb_dynamic_metadata;

INSERT INTO Person (name)
VALUES ('Alice'),
       ('Bob'),
       ('Charlie'),
       ('David'),
       ('Eve'),
       ('Frank'),
       ('Grace'),
       ('Heidi'),
       ('Ivan'),
       ('Judy');

select * from performance_schema.threads;
