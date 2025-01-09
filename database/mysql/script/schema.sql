

create database if not exists test;

use test;

create table Person
(
    id   bigint auto_increment primary key,
    name varchar(255) not null
);

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
