USE test;
CREATE TABLE  if NOT EXISTS math (
	Id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	a INT,
	b INT,
	c int DEFAULT (a+b)
);

CREATE TABLE  if NOT EXISTS student (
	Id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	mathId INT not NULL REFERENCES math (Id)
);

ALTER TABLE student 
ADD COLUMN `name` VARCHAR(40);
