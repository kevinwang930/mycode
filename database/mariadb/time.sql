USE db2;
CREATE TABLE if not exists tickets(
client_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
ticket_data DATE,
entered TIME
);

ALTER TABLE tickets
CHANGE COLUMN ticket_data ticket_date DATE;

ALTER TABLE tickets
change COLUMN promised_time promised_time TIME DEFAULT DATE_ADD(entered, INTERVAL 2 HOUR)
AFTER entered;
INSERT INTO tickets(ticket_date,entered)
VALUES(CURRENT_DATE,'02:55');


UPDATE tickets
SET promised_time = DATE_ADD(entered, INTERVAL 2 HOUR)
WHERE promised_time is NULL;



