USE employees;

CREATE SQL SECURITY INVOKER VIEW employees_workd_in_multi_dept AS 
SELECT * FROM dept_emp
WHERE emp_no IN
(SELECT emp_no FROM
dept_emp
GROUP BY emp_no
having COUNT(dept_emp.emp_no) = 2);

SELECT * FROM employees_workd_in_multi_dept;

SHOW CREATE VIEW employees_workd_in_multi_dept;

DROP VIEW if EXISTS current_dept_emp;

CREATE VIEW db2.tickets_view AS
SELECT * FROM db2.tickets;

USE db2;
SELECT * FROM tickets_view;

INSERT INTO tickets(ticket_date)
VALUES(CURRENT_DATE);

ALTER TABLE tickets
MODIFY COLUMN entered TIME DEFAULT CURRENT_TIME;




