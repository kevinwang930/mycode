CREATE DATABASE if NOT EXISTS bookstore;
USE test;
SHOW TABLES;

CREATE TABLE if NOT EXISTS books (
	BookID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	Title VARCHAR(100) NOT NULL,
	SeriesID INT,
	AuthorID INT);
	
CREATE TABLE if NOT EXISTS authors (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT);
	
CREATE TABLE if NOT EXISTS series (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT);
	
INSERT INTO books (Title,SeriesID,AuthorID) 
VALUES ('The Fellowship of the Ring',1,1), 
      ('The Two Towers',1,1), ('The Return of the King',1,1),  
      ('The Sum of All Men',2,2), ('Brotherhood of the Wolf',2,2), 
      ('Wizardborn',2,2), ('The Hobbbit',0,1);
DESCRIBE books;
SELECT * FROM books;
INSERT INTO books (Title,SeriesID,AuthorID)
VALUES ("Lair of Bones",2,2);

UPDATE books
SET Title = "The Hobbits"
WHERE BookID = 7;



