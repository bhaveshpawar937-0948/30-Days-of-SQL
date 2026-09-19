-- ============================================================
-- 30 Days of SQL
-- Day 12: SQL Subqueries
-- Author: Bhavesh Pawar
-- ============================================================

USE sql_30_days;


-- ------------------------------------------------------------
-- 1. Find students scoring above the overall average
-- ------------------------------------------------------------

SELECT
    student_name,
    score
FROM student_scores
WHERE score > (
    SELECT AVG(score)
    FROM student_scores
);


-- ------------------------------------------------------------
-- 2. Find students scoring below the overall average
-- ------------------------------------------------------------

SELECT
    student_name,
    score
FROM student_scores
WHERE score < (
    SELECT AVG(score)
    FROM student_scores
);


-- ------------------------------------------------------------
-- 3. Find the student(s) with the highest score
-- ------------------------------------------------------------

SELECT
    student_name,
    score
FROM student_scores
WHERE score = (
    SELECT MAX(score)
    FROM student_scores
);


-- ------------------------------------------------------------
-- 4. Find the student(s) with the lowest score
-- ------------------------------------------------------------

SELECT
    student_name,
    score
FROM student_scores
WHERE score = (
    SELECT MIN(score)
    FROM student_scores
);


-- ------------------------------------------------------------
-- 5. Find employees earning above company average
-- ------------------------------------------------------------

SELECT
    employee_name,
    job_role,
    salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);


-- ------------------------------------------------------------
-- 6. Find employees earning below company average
-- ------------------------------------------------------------

SELECT
    employee_name,
    job_role,
    salary
FROM employees
WHERE salary < (
    SELECT AVG(salary)
    FROM employees
);


-- ------------------------------------------------------------
-- 7. Find the highest-paid employee(s)
-- ------------------------------------------------------------

SELECT
    employee_name,
    job_role,
    salary
FROM employees
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
);


-- ------------------------------------------------------------
-- 8. Find the second-highest distinct salary
-- ------------------------------------------------------------

SELECT
    MAX(salary) AS second_highest_salary
FROM employees
WHERE salary < (
    SELECT MAX(salary)
    FROM employees
);


-- ------------------------------------------------------------
-- 9. Find employees earning the second-highest salary
-- ------------------------------------------------------------

SELECT
    employee_name,
    job_role,
    salary
FROM employees
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
    WHERE salary < (
        SELECT MAX(salary)
        FROM employees
    )
);


-- ------------------------------------------------------------
-- 10. Find departments containing a student scoring 90+
-- Multi-row subquery
-- ------------------------------------------------------------

SELECT DISTINCT
    department
FROM students
WHERE department IN (
    SELECT department
    FROM student_scores
    WHERE score >= 90
);


-- ------------------------------------------------------------
-- 11. Find all students belonging to high-performing
-- departments
-- ------------------------------------------------------------

SELECT
    student_id,
    name,
    department
FROM students
WHERE department IN (
    SELECT department
    FROM student_scores
    WHERE score >= 90
);


-- ------------------------------------------------------------
-- 12. Find students without project assignments
-- using NOT IN
-- ------------------------------------------------------------

SELECT
    student_id,
    name
FROM students
WHERE student_id NOT IN (
    SELECT student_id
    FROM student_projects
    WHERE student_id IS NOT NULL
);


-- ------------------------------------------------------------
-- 13. Find students who DO have project assignments
-- ------------------------------------------------------------

SELECT
    student_id,
    name
FROM students
WHERE student_id IN (
    SELECT student_id
    FROM student_projects
);


-- ------------------------------------------------------------
-- 14. Display every student score with overall average
-- Subquery inside SELECT
-- ------------------------------------------------------------

SELECT
    student_name,
    score,
    (
        SELECT ROUND(AVG(score), 2)
        FROM student_scores
    ) AS overall_average
FROM student_scores;


-- ------------------------------------------------------------
-- 15. Show difference between each score and average
-- ------------------------------------------------------------

SELECT
    student_name,
    score,
    ROUND(
        score - (
            SELECT AVG(score)
            FROM student_scores
        ),
        2
    ) AS difference_from_average
FROM student_scores;


-- ------------------------------------------------------------
-- 16. Display employee salary and company average
-- ------------------------------------------------------------

SELECT
    employee_name,
    salary,
    (
        SELECT ROUND(AVG(salary), 2)
        FROM employees
    ) AS company_average
FROM employees;


-- ------------------------------------------------------------
-- 17. Compare employee salary against maximum salary
-- ------------------------------------------------------------

SELECT
    employee_name,
    salary,
    (
        SELECT MAX(salary)
        FROM employees
    ) AS maximum_salary
FROM employees;


-- ------------------------------------------------------------
-- 18. Derived table:
-- Create department performance summary
-- ------------------------------------------------------------

SELECT
    department,
    average_score
FROM (
    SELECT
        department,
        ROUND(AVG(score), 2) AS average_score
    FROM student_scores
    GROUP BY department
) AS department_summary;


-- ------------------------------------------------------------
-- 19. Filter a derived table
-- Departments averaging above 80
-- ------------------------------------------------------------

SELECT
    department,
    average_score
FROM (
    SELECT
        department,
        ROUND(AVG(score), 2) AS average_score
    FROM student_scores
    GROUP BY department
) AS department_summary
WHERE average_score > 80;


-- ------------------------------------------------------------
-- 20. Rank derived department results
-- ------------------------------------------------------------

SELECT
    department,
    average_score
FROM (
    SELECT
        department,
        ROUND(AVG(score), 2) AS average_score
    FROM student_scores
    GROUP BY department
) AS department_summary
ORDER BY average_score DESC;


-- ------------------------------------------------------------
-- 21. Find employees whose salary is greater than
-- the Analytics department average
-- ------------------------------------------------------------

SELECT
    employee_name,
    department,
    salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department = 'Analytics'
);


-- ------------------------------------------------------------
-- 22. Find employees earning more than the average
-- Engineering salary
-- ------------------------------------------------------------

SELECT
    employee_name,
    department,
    salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department = 'Engineering'
);


-- ------------------------------------------------------------
-- 23. Find students whose score exceeds the average
-- score of Data Science students
-- ------------------------------------------------------------

SELECT
    student_name,
    department,
    score
FROM student_scores
WHERE score > (
    SELECT AVG(score)
    FROM student_scores
    WHERE department = 'Data Science'
);


-- ------------------------------------------------------------
-- 24. Find students scoring above the average but
-- below the highest score
-- ------------------------------------------------------------

SELECT
    student_name,
    score
FROM student_scores
WHERE score > (
    SELECT AVG(score)
    FROM student_scores
)
AND score < (
    SELECT MAX(score)
    FROM student_scores
);


-- ------------------------------------------------------------
-- 25. Find employees from departments whose average
-- salary exceeds 60000
-- ------------------------------------------------------------

SELECT
    employee_name,
    department,
    salary
FROM employees
WHERE department IN (
    SELECT department
    FROM employees
    GROUP BY department
    HAVING AVG(salary) > 60000
);


-- ------------------------------------------------------------
-- 26. Find scores belonging to departments whose
-- maximum score is at least 90
-- ------------------------------------------------------------

SELECT
    student_name,
    department,
    score
FROM student_scores
WHERE department IN (
    SELECT department
    FROM student_scores
    GROUP BY department
    HAVING MAX(score) >= 90
);


-- ------------------------------------------------------------
-- 27. Find employees earning more than the minimum
-- manager salary
-- ------------------------------------------------------------

SELECT
    employee_name,
    salary
FROM employees
WHERE salary > (
    SELECT MIN(salary)
    FROM employees
    WHERE employee_id IN (
        SELECT DISTINCT manager_id
        FROM employees
        WHERE manager_id IS NOT NULL
    )
);


-- ------------------------------------------------------------
-- 28. Derived employee salary statistics
-- ------------------------------------------------------------

SELECT
    department,
    average_salary,
    highest_salary
FROM (
    SELECT
        department,
        ROUND(AVG(salary), 2) AS average_salary,
        MAX(salary) AS highest_salary
    FROM employees
    GROUP BY department
) AS salary_summary;


-- ------------------------------------------------------------
-- 29. Find department with highest average score
-- ------------------------------------------------------------

SELECT
    department,
    average_score
FROM (
    SELECT
        department,
        ROUND(AVG(score), 2) AS average_score
    FROM student_scores
    GROUP BY department
) AS department_summary
WHERE average_score = (
    SELECT MAX(average_score)
    FROM (
        SELECT
            AVG(score) AS average_score
        FROM student_scores
        GROUP BY department
    ) AS averages
);


-- ------------------------------------------------------------
-- 30. Final analytical query:
-- Employees earning above company average
-- with difference from average
-- ------------------------------------------------------------

SELECT
    employee_name,
    department,
    job_role,
    salary,
    ROUND(
        salary - (
            SELECT AVG(salary)
            FROM employees
        ),
        2
    ) AS above_average_by
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
)
ORDER BY salary DESC;