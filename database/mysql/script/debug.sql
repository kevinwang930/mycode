SET SESSION debug='+d:t:q,skip_dd_table_access_check,parser_debug';


ALTER USER 'root'@'localhost' IDENTIFIED BY '';







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



select * from performance_schema.threads;
