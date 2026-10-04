-- ============================================================
-- 30 Days of SQL
-- Day 25: Transactions, COMMIT, ROLLBACK & SAVEPOINT
-- Author: Bhavesh Pawar
-- ============================================================

USE sql_30_days;


-- ------------------------------------------------------------
-- 1. Check autocommit status
-- ------------------------------------------------------------

SELECT @@autocommit;


-- ------------------------------------------------------------
-- 2. Check the current employee data
-- ------------------------------------------------------------

SELECT
    employee_id,
    employee_name,
    department,
    salary
FROM employees
ORDER BY employee_id;


-- ------------------------------------------------------------
-- 3. Basic transaction with ROLLBACK
-- ------------------------------------------------------------

START TRANSACTION;

UPDATE employees
SET salary = salary + 1000
WHERE employee_id = 1;

SELECT
    employee_id,
    employee_name,
    salary
FROM employees
WHERE employee_id = 1;

ROLLBACK;


-- ------------------------------------------------------------
-- 4. Verify that the update was rolled back
-- ------------------------------------------------------------

SELECT
    employee_id,
    employee_name,
    salary
FROM employees
WHERE employee_id = 1;


-- ------------------------------------------------------------
-- 5. Basic transaction with COMMIT
-- This deliberately restores the value before committing,
-- so repeated practice does not permanently raise the salary.
-- ------------------------------------------------------------

START TRANSACTION;

UPDATE employees
SET salary = salary + 1000
WHERE employee_id = 1;

UPDATE employees
SET salary = salary - 1000
WHERE employee_id = 1;

COMMIT;


-- ------------------------------------------------------------
-- 6. Verify the committed transaction
-- ------------------------------------------------------------

SELECT
    employee_id,
    employee_name,
    salary
FROM employees
WHERE employee_id = 1;


-- ------------------------------------------------------------
-- 7. Roll back updates affecting multiple rows
-- ------------------------------------------------------------

START TRANSACTION;

UPDATE employees
SET salary = salary * 1.10
WHERE department = 'Engineering';

SELECT
    employee_name,
    department,
    salary
FROM employees
WHERE department = 'Engineering';

ROLLBACK;


-- ------------------------------------------------------------
-- 8. Verify department salaries were restored
-- ------------------------------------------------------------

SELECT
    employee_name,
    department,
    salary
FROM employees
WHERE department = 'Engineering';


-- ------------------------------------------------------------
-- 9. Test DELETE safely with ROLLBACK
-- ------------------------------------------------------------

START TRANSACTION;

DELETE FROM student_scores
WHERE score < 60;

SELECT *
FROM student_scores
ORDER BY score;

ROLLBACK;


-- ------------------------------------------------------------
-- 10. Verify deleted rows were restored
-- ------------------------------------------------------------

SELECT *
FROM student_scores
ORDER BY score;


-- ------------------------------------------------------------
-- 11. Create a savepoint
-- ------------------------------------------------------------

START TRANSACTION;

UPDATE employees
SET salary = salary + 500
WHERE employee_id = 1;

SAVEPOINT salary_change;

UPDATE employees
SET department = 'Management'
WHERE employee_id = 1;

SELECT
    employee_id,
    employee_name,
    department,
    salary
FROM employees
WHERE employee_id = 1;


-- ------------------------------------------------------------
-- 12. Roll back only to the savepoint
-- ------------------------------------------------------------

ROLLBACK TO SAVEPOINT salary_change;

SELECT
    employee_id,
    employee_name,
    department,
    salary
FROM employees
WHERE employee_id = 1;

ROLLBACK;


-- ------------------------------------------------------------
-- 13. Multiple savepoints
-- ------------------------------------------------------------

START TRANSACTION;

UPDATE employees
SET salary = salary + 500
WHERE employee_id = 1;

SAVEPOINT step_one;

UPDATE employees
SET salary = salary + 500
WHERE employee_id = 2;

SAVEPOINT step_two;

UPDATE employees
SET salary = salary + 500
WHERE employee_id = 3;

SELECT
    employee_id,
    employee_name,
    salary
FROM employees
WHERE employee_id IN (1, 2, 3);


-- ------------------------------------------------------------
-- 14. Return to the second savepoint
-- ------------------------------------------------------------

ROLLBACK TO SAVEPOINT step_two;

SELECT
    employee_id,
    employee_name,
    salary
FROM employees
WHERE employee_id IN (1, 2, 3);

ROLLBACK;


-- ------------------------------------------------------------
-- 15. Return to the first savepoint
-- ------------------------------------------------------------

START TRANSACTION;

UPDATE employees
SET salary = salary + 500
WHERE employee_id = 1;

SAVEPOINT step_one_again;

UPDATE employees
SET salary = salary + 500
WHERE employee_id = 2;

UPDATE employees
SET salary = salary + 500
WHERE employee_id = 3;

ROLLBACK TO SAVEPOINT step_one_again;

SELECT
    employee_id,
    employee_name,
    salary
FROM employees
WHERE employee_id IN (1, 2, 3);

ROLLBACK;


-- ------------------------------------------------------------
-- 16. Release a savepoint
-- ------------------------------------------------------------

START TRANSACTION;

UPDATE employees
SET salary = salary + 250
WHERE employee_id = 1;

SAVEPOINT temporary_checkpoint;

RELEASE SAVEPOINT temporary_checkpoint;

ROLLBACK;


-- ------------------------------------------------------------
-- 17. Temporary department change
-- ------------------------------------------------------------

START TRANSACTION;

UPDATE employees
SET department = 'Research'
WHERE employee_id = 2;

SELECT
    employee_id,
    employee_name,
    department
FROM employees
WHERE employee_id = 2;

ROLLBACK;


-- ------------------------------------------------------------
-- 18. Verify department restoration
-- ------------------------------------------------------------

SELECT
    employee_id,
    employee_name,
    department
FROM employees
WHERE employee_id = 2;


-- ------------------------------------------------------------
-- 19. Safe student score experiment
-- ------------------------------------------------------------

START TRANSACTION;

UPDATE student_scores
SET score = score + 5
WHERE score <= 90;

SELECT
    student_id,
    student_name,
    score
FROM student_scores
ORDER BY score DESC;

ROLLBACK;


-- ------------------------------------------------------------
-- 20. Verify scores after rollback
-- ------------------------------------------------------------

SELECT
    student_id,
    student_name,
    score
FROM student_scores
ORDER BY score DESC;


-- ------------------------------------------------------------
-- 21. Savepoint before a bulk update
-- ------------------------------------------------------------

START TRANSACTION;

SAVEPOINT before_bulk_update;

UPDATE employees
SET salary = salary * 1.05;

SELECT
    employee_name,
    salary
FROM employees
ORDER BY employee_id;

ROLLBACK TO SAVEPOINT before_bulk_update;

ROLLBACK;


-- ------------------------------------------------------------
-- 22. Simulate transferring budget between two employees
-- Total salary amount remains unchanged.
-- ------------------------------------------------------------

START TRANSACTION;

UPDATE employees
SET salary = salary - 1000
WHERE employee_id = 1
  AND salary >= 1000;

UPDATE employees
SET salary = salary + 1000
WHERE employee_id = 2;

SELECT
    employee_id,
    employee_name,
    salary
FROM employees
WHERE employee_id IN (1, 2);

ROLLBACK;


-- ------------------------------------------------------------
-- 23. Check total before a transfer simulation
-- ------------------------------------------------------------

SELECT
    SUM(salary) AS total_salary
FROM employees;


-- ------------------------------------------------------------
-- 24. Perform and inspect a temporary transfer
-- ------------------------------------------------------------

START TRANSACTION;

UPDATE employees
SET salary = salary - 500
WHERE employee_id = 1
  AND salary >= 500;

UPDATE employees
SET salary = salary + 500
WHERE employee_id = 2;

SELECT
    SUM(salary) AS total_salary_during_transaction
FROM employees;

ROLLBACK;


-- ------------------------------------------------------------
-- 25. Confirm total after rollback
-- ------------------------------------------------------------

SELECT
    SUM(salary) AS total_salary_after_rollback
FROM employees;


-- ------------------------------------------------------------
-- 26. Savepoint-based student score correction
-- ------------------------------------------------------------

START TRANSACTION;

UPDATE student_scores
SET score = score + 2
WHERE student_id = 1;

SAVEPOINT first_correction;

UPDATE student_scores
SET score = score + 20
WHERE student_id = 2;

SELECT
    student_id,
    student_name,
    score
FROM student_scores
WHERE student_id IN (1, 2);

ROLLBACK TO SAVEPOINT first_correction;

SELECT
    student_id,
    student_name,
    score
FROM student_scores
WHERE student_id IN (1, 2);

ROLLBACK;


-- ------------------------------------------------------------
-- 27. Simulate multiple business operations
-- ------------------------------------------------------------

START TRANSACTION;

UPDATE employees
SET salary = salary + 750
WHERE employee_id = 1;

SAVEPOINT employee_one_complete;

UPDATE employees
SET salary = salary + 750
WHERE employee_id = 2;

SAVEPOINT employee_two_complete;

UPDATE employees
SET salary = salary + 750
WHERE employee_id = 3;

SELECT
    employee_id,
    employee_name,
    salary
FROM employees
WHERE employee_id IN (1, 2, 3);

ROLLBACK TO SAVEPOINT employee_two_complete;

ROLLBACK;


-- ------------------------------------------------------------
-- 28. Inspect the table storage engine
-- ------------------------------------------------------------

SHOW TABLE STATUS
LIKE 'employees';


-- ------------------------------------------------------------
-- 29. Demonstrate a transaction that leaves data unchanged
-- after COMMIT
-- ------------------------------------------------------------

START TRANSACTION;

UPDATE employees
SET salary = salary + 100
WHERE employee_id = 1;

UPDATE employees
SET salary = salary - 100
WHERE employee_id = 1;

COMMIT;

SELECT
    employee_id,
    employee_name,
    salary
FROM employees
WHERE employee_id = 1;


-- ------------------------------------------------------------
-- 30. Final transaction practice
-- ------------------------------------------------------------

START TRANSACTION;

-- First valid operation
UPDATE employees
SET salary = salary + 500
WHERE employee_id = 1;

SAVEPOINT after_first_update;

-- Second temporary operation
UPDATE employees
SET salary = salary + 1000
WHERE employee_id = 2;

-- Undo only the second operation
ROLLBACK TO SAVEPOINT after_first_update;

SELECT
    employee_id,
    employee_name,
    salary
FROM employees
WHERE employee_id IN (1, 2);

-- Undo the remaining practice change
ROLLBACK;


-- Final verification

SELECT
    employee_id,
    employee_name,
    department,
    salary
FROM employees
ORDER BY employee_id;