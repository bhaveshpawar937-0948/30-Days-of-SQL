-- ============================================================
-- 30 Days of SQL
-- Day 24: Indexes & Query Optimization
-- Author: Bhavesh Pawar
-- ============================================================

USE sql_30_days;


-- ------------------------------------------------------------
-- 1. Inspect indexes already available
-- ------------------------------------------------------------

SHOW INDEX FROM employees;


-- ------------------------------------------------------------
-- 2. Examine a department lookup before adding our index
-- ------------------------------------------------------------

EXPLAIN
SELECT
    employee_id,
    employee_name,
    department
FROM employees
WHERE department = 'Engineering';


-- ------------------------------------------------------------
-- 3. Create a department index
-- ------------------------------------------------------------

CREATE INDEX idx_employee_department
ON employees(department);


-- ------------------------------------------------------------
-- 4. Examine the query after creating the index
-- ------------------------------------------------------------

EXPLAIN
SELECT
    employee_id,
    employee_name,
    department
FROM employees
WHERE department = 'Engineering';


-- ------------------------------------------------------------
-- 5. Create a salary index
-- ------------------------------------------------------------

CREATE INDEX idx_employee_salary
ON employees(salary);


-- ------------------------------------------------------------
-- 6. Examine an equality salary lookup
-- ------------------------------------------------------------

EXPLAIN
SELECT
    employee_id,
    employee_name,
    salary
FROM employees
WHERE salary = 75000;


-- ------------------------------------------------------------
-- 7. Examine a salary range lookup
-- ------------------------------------------------------------

EXPLAIN
SELECT
    employee_id,
    employee_name,
    salary
FROM employees
WHERE salary BETWEEN 60000 AND 80000;


-- ------------------------------------------------------------
-- 8. Create a composite department-salary index
-- ------------------------------------------------------------

CREATE INDEX idx_department_salary
ON employees(department, salary);


-- ------------------------------------------------------------
-- 9. Use both columns from the composite index
-- ------------------------------------------------------------

EXPLAIN
SELECT
    employee_id,
    employee_name,
    department,
    salary
FROM employees
WHERE department = 'Engineering'
  AND salary >= 70000;


-- ------------------------------------------------------------
-- 10. Test the leftmost column by itself
-- ------------------------------------------------------------

EXPLAIN
SELECT
    employee_name,
    department
FROM employees
WHERE department = 'Engineering';


-- ------------------------------------------------------------
-- 11. Test only the second composite-index column
-- ------------------------------------------------------------

EXPLAIN
SELECT
    employee_name,
    salary
FROM employees
WHERE salary >= 70000;


-- ------------------------------------------------------------
-- 12. Inspect indexes again
-- ------------------------------------------------------------

SHOW INDEX FROM employees;


-- ------------------------------------------------------------
-- 13. Create a job-role index
-- ------------------------------------------------------------

CREATE INDEX idx_employee_job_role
ON employees(job_role);


-- ------------------------------------------------------------
-- 14. Inspect a job-role lookup
-- ------------------------------------------------------------

EXPLAIN
SELECT
    employee_id,
    employee_name,
    job_role
FROM employees
WHERE job_role = 'Data Analyst';


-- ------------------------------------------------------------
-- 15. Create a covering-index candidate
-- ------------------------------------------------------------

CREATE INDEX idx_department_name_salary
ON employees(
    department,
    employee_name,
    salary
);


-- ------------------------------------------------------------
-- 16. Examine a query covered by indexed columns
-- ------------------------------------------------------------

EXPLAIN
SELECT
    employee_name,
    salary
FROM employees
WHERE department = 'Engineering';


-- ------------------------------------------------------------
-- 17. Inspect sorting with the composite index
-- ------------------------------------------------------------

EXPLAIN
SELECT
    employee_name,
    salary
FROM employees
WHERE department = 'Engineering'
ORDER BY salary;


-- ------------------------------------------------------------
-- 18. Create an index for hire dates
-- ------------------------------------------------------------

CREATE INDEX idx_employee_hire_date
ON employees(hire_date);


-- ------------------------------------------------------------
-- 19. Non-sargable date filter example
-- ------------------------------------------------------------

EXPLAIN
SELECT
    employee_id,
    employee_name,
    hire_date
FROM employees
WHERE YEAR(hire_date) = 2026;


-- ------------------------------------------------------------
-- 20. Rewrite as an index-friendly date range
-- ------------------------------------------------------------

EXPLAIN
SELECT
    employee_id,
    employee_name,
    hire_date
FROM employees
WHERE hire_date >= '2026-01-01'
  AND hire_date < '2027-01-01';


-- ------------------------------------------------------------
-- 21. Compare SELECT * with required columns
-- ------------------------------------------------------------

EXPLAIN
SELECT *
FROM employees
WHERE department = 'Engineering';


EXPLAIN
SELECT
    employee_name,
    salary
FROM employees
WHERE department = 'Engineering';


-- ------------------------------------------------------------
-- 22. Create an index for manager lookups
-- ------------------------------------------------------------

CREATE INDEX idx_employee_manager
ON employees(manager_id);


-- ------------------------------------------------------------
-- 23. Inspect the employee-manager join
-- ------------------------------------------------------------

EXPLAIN
SELECT
    e.employee_name,
    m.employee_name AS manager_name
FROM employees AS e
LEFT JOIN employees AS m
    ON e.manager_id = m.employee_id;


-- ------------------------------------------------------------
-- 24. Create an index on student scores
-- ------------------------------------------------------------

CREATE INDEX idx_student_score
ON student_scores(score);


-- ------------------------------------------------------------
-- 25. Inspect student score range lookup
-- ------------------------------------------------------------

EXPLAIN
SELECT
    student_id,
    student_name,
    score
FROM student_scores
WHERE score >= 80;


-- ------------------------------------------------------------
-- 26. Composite index for department-score analysis
-- ------------------------------------------------------------

CREATE INDEX idx_student_department_score
ON student_scores(department, score);


-- ------------------------------------------------------------
-- 27. Inspect department-score filtering
-- ------------------------------------------------------------

EXPLAIN
SELECT
    student_name,
    department,
    score
FROM student_scores
WHERE department = 'AI & DS'
  AND score >= 80;


-- ------------------------------------------------------------
-- 28. Inspect an aggregate using an indexed filter
-- ------------------------------------------------------------

EXPLAIN
SELECT
    department,
    COUNT(*) AS employee_count,
    AVG(salary) AS average_salary
FROM employees
WHERE department = 'Engineering'
GROUP BY department;


-- ------------------------------------------------------------
-- 29. Remove selected practice indexes
-- ------------------------------------------------------------

DROP INDEX idx_employee_job_role
ON employees;

DROP INDEX idx_department_name_salary
ON employees;


-- ------------------------------------------------------------
-- 30. Final optimized analytical query inspection
-- ------------------------------------------------------------

EXPLAIN
SELECT
    department,
    COUNT(*) AS employee_count,
    ROUND(AVG(salary), 2) AS average_salary,
    MIN(salary) AS minimum_salary,
    MAX(salary) AS maximum_salary
FROM employees
WHERE department = 'Engineering'
  AND salary >= 60000
GROUP BY department;


-- Final index inspection

SHOW INDEX FROM employees;