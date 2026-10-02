-- ============================================================
-- 30 Days of SQL
-- Day 23: Views & Reusable SQL Queries
-- Author: Bhavesh Pawar
-- ============================================================

USE sql_30_days;


-- ------------------------------------------------------------
-- 1. Create a basic employee view
-- ------------------------------------------------------------

DROP VIEW IF EXISTS employee_basic_view;

CREATE VIEW employee_basic_view AS

SELECT
    employee_id,
    employee_name,
    department,
    job_role,
    salary

FROM employees;


-- ------------------------------------------------------------
-- 2. Query the basic employee view
-- ------------------------------------------------------------

SELECT *
FROM employee_basic_view;


-- ------------------------------------------------------------
-- 3. Create a high-salary employee view
-- ------------------------------------------------------------

DROP VIEW IF EXISTS high_salary_employees;

CREATE VIEW high_salary_employees AS

SELECT
    employee_id,
    employee_name,
    department,
    salary

FROM employees

WHERE salary >= 70000;


-- ------------------------------------------------------------
-- 4. Query high-salary employees
-- ------------------------------------------------------------

SELECT *
FROM high_salary_employees

ORDER BY salary DESC;


-- ------------------------------------------------------------
-- 5. Create Engineering employee view
-- ------------------------------------------------------------

DROP VIEW IF EXISTS engineering_employees;

CREATE VIEW engineering_employees AS

SELECT
    employee_id,
    employee_name,
    job_role,
    salary

FROM employees

WHERE department = 'Engineering';


-- ------------------------------------------------------------
-- 6. Query Engineering employee view
-- ------------------------------------------------------------

SELECT *
FROM engineering_employees

ORDER BY salary DESC;


-- ------------------------------------------------------------
-- 7. Create employee-manager view
-- ------------------------------------------------------------

DROP VIEW IF EXISTS employee_manager_view;

CREATE VIEW employee_manager_view AS

SELECT
    e.employee_id,
    e.employee_name,
    e.department,
    e.job_role,
    e.salary,

    COALESCE(
        m.employee_name,
        'No Manager'
    ) AS manager_name

FROM employees AS e

LEFT JOIN employees AS m
    ON e.manager_id = m.employee_id;


-- ------------------------------------------------------------
-- 8. Query employee-manager view
-- ------------------------------------------------------------

SELECT *
FROM employee_manager_view

ORDER BY department, employee_name;


-- ------------------------------------------------------------
-- 9. Create department salary summary view
-- ------------------------------------------------------------

DROP VIEW IF EXISTS department_salary_summary;

CREATE VIEW department_salary_summary AS

SELECT
    department,
    COUNT(*) AS employee_count,
    ROUND(AVG(salary), 2)
        AS average_salary,
    MIN(salary)
        AS minimum_salary,
    MAX(salary)
        AS maximum_salary,
    SUM(salary)
        AS total_payroll

FROM employees

GROUP BY department;


-- ------------------------------------------------------------
-- 10. Query department salary summary
-- ------------------------------------------------------------

SELECT *
FROM department_salary_summary

ORDER BY average_salary DESC;


-- ------------------------------------------------------------
-- 11. Filter results from a view
-- ------------------------------------------------------------

SELECT *
FROM department_salary_summary

WHERE average_salary >= 70000

ORDER BY average_salary DESC;


-- ------------------------------------------------------------
-- 12. Create employee salary category view
-- ------------------------------------------------------------

DROP VIEW IF EXISTS employee_salary_categories;

CREATE VIEW employee_salary_categories AS

SELECT
    employee_id,
    employee_name,
    department,
    salary,

    CASE
        WHEN salary >= 80000
            THEN 'High Salary'

        WHEN salary >= 60000
            THEN 'Medium Salary'

        ELSE 'Entry Salary'
    END AS salary_category

FROM employees;


-- ------------------------------------------------------------
-- 13. Query salary category view
-- ------------------------------------------------------------

SELECT *
FROM employee_salary_categories

ORDER BY salary DESC;


-- ------------------------------------------------------------
-- 14. Count employees by category using the view
-- ------------------------------------------------------------

SELECT
    salary_category,
    COUNT(*) AS employee_count

FROM employee_salary_categories

GROUP BY salary_category

ORDER BY employee_count DESC;


-- ------------------------------------------------------------
-- 15. Create student performance view
-- ------------------------------------------------------------

DROP VIEW IF EXISTS student_performance_view;

CREATE VIEW student_performance_view AS

SELECT
    student_id,
    student_name,
    department,
    score,

    CASE
        WHEN score >= 90 THEN 'Excellent'
        WHEN score >= 80 THEN 'Very Good'
        WHEN score >= 70 THEN 'Good'
        WHEN score >= 60 THEN 'Average'
        ELSE 'Needs Improvement'
    END AS performance_category

FROM student_scores;


-- ------------------------------------------------------------
-- 16. Query student performance view
-- ------------------------------------------------------------

SELECT *
FROM student_performance_view

ORDER BY score DESC;


-- ------------------------------------------------------------
-- 17. Filter excellent students from view
-- ------------------------------------------------------------

SELECT *
FROM student_performance_view

WHERE performance_category = 'Excellent';


-- ------------------------------------------------------------
-- 18. Create department score summary view
-- ------------------------------------------------------------

DROP VIEW IF EXISTS department_score_summary;

CREATE VIEW department_score_summary AS

SELECT
    department,
    COUNT(*) AS student_count,
    ROUND(AVG(score), 2)
        AS average_score,
    MIN(score)
        AS minimum_score,
    MAX(score)
        AS maximum_score

FROM student_scores

GROUP BY department;


-- ------------------------------------------------------------
-- 19. Query department score summary
-- ------------------------------------------------------------

SELECT *
FROM department_score_summary

ORDER BY average_score DESC;


-- ------------------------------------------------------------
-- 20. Create student-project view
-- ------------------------------------------------------------

DROP VIEW IF EXISTS student_project_view;

CREATE VIEW student_project_view AS

SELECT
    s.student_id,
    s.name AS student_name,
    s.department,

    COALESCE(
        p.project_name,
        'No Project'
    ) AS project_name,

    COALESCE(
        p.project_status,
        'Not Assigned'
    ) AS project_status

FROM students AS s

LEFT JOIN student_projects AS p
    ON s.student_id = p.student_id;


-- ------------------------------------------------------------
-- 21. Query student-project view
-- ------------------------------------------------------------

SELECT *
FROM student_project_view

ORDER BY student_id;


-- ------------------------------------------------------------
-- 22. Find students without projects using view
-- ------------------------------------------------------------

SELECT *
FROM student_project_view

WHERE project_status = 'Not Assigned';


-- ------------------------------------------------------------
-- 23. Create manager summary view
-- ------------------------------------------------------------

DROP VIEW IF EXISTS manager_summary_view;

CREATE VIEW manager_summary_view AS

SELECT
    m.employee_id AS manager_id,
    m.employee_name AS manager_name,
    m.department,

    COUNT(e.employee_id)
        AS direct_reports

FROM employees AS m

JOIN employees AS e
    ON e.manager_id = m.employee_id

GROUP BY
    m.employee_id,
    m.employee_name,
    m.department;


-- ------------------------------------------------------------
-- 24. Query manager summary
-- ------------------------------------------------------------

SELECT *
FROM manager_summary_view

ORDER BY direct_reports DESC;


-- ------------------------------------------------------------
-- 25. Create public employee directory
-- ------------------------------------------------------------

DROP VIEW IF EXISTS public_employee_directory;

CREATE VIEW public_employee_directory AS

SELECT
    employee_name,
    department,
    job_role

FROM employees;


-- ------------------------------------------------------------
-- 26. Query public employee directory
-- ------------------------------------------------------------

SELECT *
FROM public_employee_directory

ORDER BY department, employee_name;


-- ------------------------------------------------------------
-- 27. Create dashboard-ready employee view
-- ------------------------------------------------------------

DROP VIEW IF EXISTS employee_dashboard_view;

CREATE VIEW employee_dashboard_view AS

SELECT
    e.employee_id,
    e.employee_name,
    e.department,
    e.job_role,
    e.salary,

    CASE
        WHEN e.salary >= 80000
            THEN 'High Salary'

        WHEN e.salary >= 60000
            THEN 'Medium Salary'

        ELSE 'Entry Salary'
    END AS salary_category,

    COALESCE(
        m.employee_name,
        'No Manager'
    ) AS manager_name

FROM employees AS e

LEFT JOIN employees AS m
    ON e.manager_id = m.employee_id;


-- ------------------------------------------------------------
-- 28. Query dashboard-ready employee view
-- ------------------------------------------------------------

SELECT *
FROM employee_dashboard_view

ORDER BY department, salary DESC;


-- ------------------------------------------------------------
-- 29. Replace an existing view definition
-- ------------------------------------------------------------

CREATE OR REPLACE VIEW high_salary_employees AS

SELECT
    employee_id,
    employee_name,
    department,
    job_role,
    salary

FROM employees

WHERE salary >= 75000;


-- Check updated view

SELECT *
FROM high_salary_employees

ORDER BY salary DESC;


-- ------------------------------------------------------------
-- 30. Final reusable reporting query using views
-- ------------------------------------------------------------

SELECT
    d.department,
    d.employee_count,
    d.average_salary,
    d.minimum_salary,
    d.maximum_salary,
    d.total_payroll,

    COUNT(
        CASE
            WHEN e.salary_category = 'High Salary'
            THEN 1
        END
    ) AS high_salary_employees

FROM department_salary_summary AS d

JOIN employee_salary_categories AS e
    ON d.department = e.department

GROUP BY
    d.department,
    d.employee_count,
    d.average_salary,
    d.minimum_salary,
    d.maximum_salary,
    d.total_payroll

ORDER BY d.average_salary DESC;