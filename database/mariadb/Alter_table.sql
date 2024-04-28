USE bookstore;
DROP TABLE if EXISTS clients;

CREATE TABLE If NOT EXISTS clients (
cust_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
NAME VARCHAR(20),
state CHAR(2),
zip VARCHAR(10),
client_type VARCHAR(4),
status CHAR(2)
);



ALTER TABLE clients
ADD COLUMN if NOT EXISTS address VARCHAR(20)
AFTER NAME;

ALTER TABLE clients
CHANGE COLUMN if EXISTS STATUS active ENUM('yes','no','AC','IA');

UPDATE clients 
SET active = 'yes'
WHERE active = 'AC';

UPDATE clients
SET active = 'no'
WHERE active = 'IA';

ALTER TABLE clients
MODIFY COLUMN if EXISTS active ENUM('yes','no');

ALTER TABLE clients
DROP client_type;

ALTER TABLE clients
ALTER state SET DEFAULT 'LA';

ALTER TABLE clients
ALTER column state DROP DEFAULT;

ALTER TABLE clients
DROP PRIMARY KEY,
CHANGE cust_id client_id INT PRIMARY KEY;

CREATE DATABASE if NOT EXISTS db2;
RENAME TABLE clients 
TO db2.clients_addresses;


ALTER TABLE employees
change COLUMN if EXISTS age age int default timestampdiff(year,birth_date,current_date);

UPDATE employees
SET age = default;

ALTER TABLE employees
DROP COLUMN if EXISTS age;

DROP TABLE if EXISTS post;
DROP TABLE if EXISTS user;