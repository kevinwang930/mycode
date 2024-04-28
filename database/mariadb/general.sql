USE pharmacy;

ALTER TABLE customer
CHANGE COLUMN if EXISTS phone phone VARCHAR(11);