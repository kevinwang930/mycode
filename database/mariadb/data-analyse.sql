USE employees;

SELECT TIMESTAMPDIFF(YEAR,birth_date,CURRENT_DATE) AS age,gender,COUNT(*)
FROM employees
GROUP BY age,gender;employees