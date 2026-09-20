-- ============================================================
-- 30 Days of SQL
-- Day 13: Correlated Subqueries, EXISTS & NOT EXISTS
-- Author: Bhavesh Pawar
-- ============================================================

USE sql_30_days;


-- ------------------------------------------------------------
-- 1. Employees earning above their department average
-- ------------------------------------------------------------

SELECT
    e.employee_name,
    e.department,
    e.salary
FROM employees AS e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employees AS e2
    WHERE e2.department = e.department
);


-- ------------------------------------------------------------
-- 2. Employees earning below their department average
-- ------------------------------------------------------------

SELECT
    e.employee_name,
    e.department,
    e.salary
FROM employees AS e
WHERE e.salary < (
    SELECT AVG(e2.salary)
    FROM employees AS e2
    WHERE e2.department = e.department
);


-- ------------------------------------------------------------
-- 3. Highest-paid employee in each department
-- ------------------------------------------------------------

SELECT
    e.employee_name,
    e.department,
    e.salary
FROM employees AS e
WHERE e.salary = (
    SELECT MAX(e2.salary)
    FROM employees AS e2
    WHERE e2.department = e.department
);


-- ------------------------------------------------------------
-- 4. Lowest-paid employee in each department
-- ------------------------------------------------------------

SELECT
    e.employee_name,
    e.department,
    e.salary
FROM employees AS e
WHERE e.salary = (
    SELECT MIN(e2.salary)
    FROM employees AS e2
    WHERE e2.department = e.department
);


-- ------------------------------------------------------------
-- 5. Students scoring above their department average
-- ------------------------------------------------------------

SELECT
    s1.student_name,
    s1.department,
    s1.score
FROM student_scores AS s1
WHERE s1.score > (
    SELECT AVG(s2.score)
    FROM student_scores AS s2
    WHERE s2.department = s1.department
);


-- ------------------------------------------------------------
-- 6. Students scoring below their department average
-- ------------------------------------------------------------

SELECT
    s1.student_name,
    s1.department,
    s1.score
FROM student_scores AS s1
WHERE s1.score < (
    SELECT AVG(s2.score)
    FROM student_scores AS s2
    WHERE s2.department = s1.department
);


-- ------------------------------------------------------------
-- 7. Highest-scoring student in each department
-- ------------------------------------------------------------

SELECT
    s1.student_name,
    s1.department,
    s1.score
FROM student_scores AS s1
WHERE s1.score = (
    SELECT MAX(s2.score)
    FROM student_scores AS s2
    WHERE s2.department = s1.department
);


-- ------------------------------------------------------------
-- 8. Students who have at least one project
-- EXISTS
-- ------------------------------------------------------------

SELECT
    s.student_id,
    s.name,
    s.department
FROM students AS s
WHERE EXISTS (
    SELECT 1
    FROM student_projects AS p
    WHERE p.student_id = s.student_id
);


-- ------------------------------------------------------------
-- 9. Students who do not have a project
-- NOT EXISTS
-- ------------------------------------------------------------

SELECT
    s.student_id,
    s.name,
    s.department
FROM students AS s
WHERE NOT EXISTS (
    SELECT 1
    FROM student_projects AS p
    WHERE p.student_id = s.student_id
);


-- ------------------------------------------------------------
-- 10. Students who have a completed project
-- ------------------------------------------------------------

SELECT
    s.student_id,
    s.name
FROM students AS s
WHERE EXISTS (
    SELECT 1
    FROM student_projects AS p
    WHERE p.student_id = s.student_id
      AND p.project_status = 'Completed'
);


-- ------------------------------------------------------------
-- 11. Students who have no completed project
-- ------------------------------------------------------------

SELECT
    s.student_id,
    s.name
FROM students AS s
WHERE NOT EXISTS (
    SELECT 1
    FROM student_projects AS p
    WHERE p.student_id = s.student_id
      AND p.project_status = 'Completed'
);


-- ------------------------------------------------------------
-- 12. Students with a project currently in progress
-- ------------------------------------------------------------

SELECT
    s.student_id,
    s.name
FROM students AS s
WHERE EXISTS (
    SELECT 1
    FROM student_projects AS p
    WHERE p.student_id = s.student_id
      AND p.project_status = 'In Progress'
);


-- ------------------------------------------------------------
-- 13. Employees who manage at least one employee
-- ------------------------------------------------------------

SELECT
    e.employee_id,
    e.employee_name,
    e.job_role
FROM employees AS e
WHERE EXISTS (
    SELECT 1
    FROM employees AS subordinate
    WHERE subordinate.manager_id = e.employee_id
);


-- ------------------------------------------------------------
-- 14. Employees who manage nobody
-- ------------------------------------------------------------

SELECT
    e.employee_id,
    e.employee_name,
    e.job_role
FROM employees AS e
WHERE NOT EXISTS (
    SELECT 1
    FROM employees AS subordinate
    WHERE subordinate.manager_id = e.employee_id
);


-- ------------------------------------------------------------
-- 15. Employees with a manager
-- ------------------------------------------------------------

SELECT
    e.employee_id,
    e.employee_name,
    e.manager_id
FROM employees AS e
WHERE EXISTS (
    SELECT 1
    FROM employees AS manager
    WHERE manager.employee_id = e.manager_id
);


-- ------------------------------------------------------------
-- 16. Top-level employees with no manager
-- ------------------------------------------------------------

SELECT
    e.employee_id,
    e.employee_name,
    e.job_role
FROM employees AS e
WHERE NOT EXISTS (
    SELECT 1
    FROM employees AS manager
    WHERE manager.employee_id = e.manager_id
);


-- ------------------------------------------------------------
-- 17. Departments containing at least one student
-- scoring 90 or higher
-- ------------------------------------------------------------

SELECT DISTINCT
    s1.department
FROM student_scores AS s1
WHERE EXISTS (
    SELECT 1
    FROM student_scores AS s2
    WHERE s2.department = s1.department
      AND s2.score >= 90
);


-- ------------------------------------------------------------
-- 18. Departments with no student scoring below 70
-- ------------------------------------------------------------

SELECT DISTINCT
    s1.department
FROM student_scores AS s1
WHERE NOT EXISTS (
    SELECT 1
    FROM student_scores AS s2
    WHERE s2.department = s1.department
      AND s2.score < 70
);


-- ------------------------------------------------------------
-- 19. Employees earning more than every lower-paid
-- colleague in the same department
-- This identifies department maximum salaries
-- ------------------------------------------------------------

SELECT
    e.employee_name,
    e.department,
    e.salary
FROM employees AS e
WHERE NOT EXISTS (
    SELECT 1
    FROM employees AS e2
    WHERE e2.department = e.department
      AND e2.salary > e.salary
);


-- ------------------------------------------------------------
-- 20. Students with no higher-scoring student
-- in their own department
-- ------------------------------------------------------------

SELECT
    s1.student_name,
    s1.department,
    s1.score
FROM student_scores AS s1
WHERE NOT EXISTS (
    SELECT 1
    FROM student_scores AS s2
    WHERE s2.department = s1.department
      AND s2.score > s1.score
);


-- ------------------------------------------------------------
-- 21. Students who share their city with another student
-- ------------------------------------------------------------

SELECT
    s1.student_id,
    s1.name,
    s1.city
FROM students AS s1
WHERE EXISTS (
    SELECT 1
    FROM students AS s2
    WHERE s2.city = s1.city
      AND s2.student_id <> s1.student_id
);


-- ------------------------------------------------------------
-- 22. Students who are the only student from their city
-- ------------------------------------------------------------

SELECT
    s1.student_id,
    s1.name,
    s1.city
FROM students AS s1
WHERE NOT EXISTS (
    SELECT 1
    FROM students AS s2
    WHERE s2.city = s1.city
      AND s2.student_id <> s1.student_id
);


-- ------------------------------------------------------------
-- 23. Employees who share their department with
-- at least one other employee
-- ------------------------------------------------------------

SELECT
    e1.employee_id,
    e1.employee_name,
    e1.department
FROM employees AS e1
WHERE EXISTS (
    SELECT 1
    FROM employees AS e2
    WHERE e2.department = e1.department
      AND e2.employee_id <> e1.employee_id
);


-- ------------------------------------------------------------
-- 24. Employees who are the only person
-- in their department
-- ------------------------------------------------------------

SELECT
    e1.employee_id,
    e1.employee_name,
    e1.department
FROM employees AS e1
WHERE NOT EXISTS (
    SELECT 1
    FROM employees AS e2
    WHERE e2.department = e1.department
      AND e2.employee_id <> e1.employee_id
);


-- ------------------------------------------------------------
-- 25. Students whose score is above another student's
-- score in the same department
-- ------------------------------------------------------------

SELECT DISTINCT
    s1.student_name,
    s1.department,
    s1.score
FROM student_scores AS s1
WHERE EXISTS (
    SELECT 1
    FROM student_scores AS s2
    WHERE s2.department = s1.department
      AND s2.score < s1.score
);


-- ------------------------------------------------------------
-- 26. Students with the lowest score in their department
-- ------------------------------------------------------------

SELECT
    s1.student_name,
    s1.department,
    s1.score
FROM student_scores AS s1
WHERE NOT EXISTS (
    SELECT 1
    FROM student_scores AS s2
    WHERE s2.department = s1.department
      AND s2.score < s1.score
);


-- ------------------------------------------------------------
-- 27. Find managers with employees earning above 65000
-- ------------------------------------------------------------

SELECT
    m.employee_id,
    m.employee_name,
    m.job_role
FROM employees AS m
WHERE EXISTS (
    SELECT 1
    FROM employees AS e
    WHERE e.manager_id = m.employee_id
      AND e.salary > 65000
);


-- ------------------------------------------------------------
-- 28. Find managers whose direct reports all earn
-- at least 50000
-- ------------------------------------------------------------

SELECT
    m.employee_id,
    m.employee_name
FROM employees AS m
WHERE EXISTS (
    SELECT 1
    FROM employees AS e
    WHERE e.manager_id = m.employee_id
)
AND NOT EXISTS (
    SELECT 1
    FROM employees AS e
    WHERE e.manager_id = m.employee_id
      AND e.salary < 50000
);


-- ------------------------------------------------------------
-- 29. Compare each employee to colleagues in their department
-- Return employees above department average
-- ------------------------------------------------------------

SELECT
    e.employee_name,
    e.department,
    e.salary,
    ROUND(
        (
            SELECT AVG(e2.salary)
            FROM employees AS e2
            WHERE e2.department = e.department
        ),
        2
    ) AS department_average
FROM employees AS e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employees AS e2
    WHERE e2.department = e.department
);


-- ------------------------------------------------------------
-- 30. Final relationship audit
-- Show students and whether a project record exists
-- ------------------------------------------------------------

SELECT
    s.student_id,
    s.name,
    CASE
        WHEN EXISTS (
            SELECT 1
            FROM student_projects AS p
            WHERE p.student_id = s.student_id
        )
        THEN 'Project Assigned'
        ELSE 'No Project'
    END AS project_relationship
FROM students AS s
ORDER BY s.student_id;