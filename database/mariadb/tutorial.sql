CREATE DATABASE if NOT EXISTS flask;
USE flask;
SHOW TABLES;

#create tables
CREATE TABLE if NOT EXISTS books (
	isbn CHAR(20)  PRIMARY KEY,
	Title VARCHAR(100) NOT NULL,
	author_id INT,
	publisher_id INT,
	year_pub CHAR(4),
	description text);
	
	
CREATE TABLE if NOT EXISTS authors (
author_id INT AUTO_INCREMENT PRIMARY KEY,
name_last VARCHAR(50),
name_first VARCHAR(50),
country VARCHAR(50));

DESCRIBE books;

#Entering data	
INSERT INTO authors
(name_last, name_first, country)
VALUES('Kafka', 'Franz', 'Czech Republic');

INSERT INTO authors
(name_last, name_first, country)
VALUES('Kevin', 'Wang', 'China');


	
INSERT INTO books (Title,Author_id,isbn,year_pub) 
VALUES ('The Trial', 1, '0805210407', '1995'),
('The Metamorphosis', 1, '0553213695', '1995'),
('America', 1, '0805210644', '1995');


#Retrieving data
SELECT * FROM books;

SELECT Title FROM books;
SELECT title FROM books LIMIT 2; #limit number of rows retrieved
SELECT title,name_last 
FROM books 
JOIN authors USING(author_id);  #join combine data from tables

SELECT title AS 'Kafka Books'
FROM books 
JOIN authors USING (author_id)
WHERE name_last = 'kafka';


#changing and deleting data
UPDATE books
SET Title = "Amerika"
WHERE isbn = '0805210644';

REPLACE INTO bookstore.books(isbn,title,author_id,year_pub)
VALUES (  '0805210644','China', 1,'1995');

DELETE FROM books
WHERE author_id = '2034';

INSERT IGNORE INTO table1 
(id, col1, col2, status) 
VALUES('1012','text','text','new'),
('1025,'text','text','new'),
('1030,'text','text','new')
ON DUPLICATE KEY 
UPDATE status = 'old';



# select advanced 
USE employees;
SELECT emp_no,first_name,last_name
FROM employees
LIMIT 5,10;  # limit number of rows retrieved to 10 start after 5

USE bookstore;

SELECT SQL_CALC_FOUND_ROWS isbn,title,
CONCAT(name_first,' ',name_last) AS author
FROM books
JOIN authors USING(author_id)
WHERE name_last like 'kaf%'
ORDER BY title ASC
LIMIT 2;

SELECT FOUND_ROWS();





