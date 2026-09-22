-- ============================================================
-- 30 Days of SQL
-- Day 15: NULL Handling
-- COALESCE, IFNULL, NULLIF & NULL-Safe Logic
-- Author: Bhavesh Pawar
-- ============================================================

USE sql_30_days;


-- ------------------------------------------------------------
-- 1. Find employees whose manager is unknown
-- ------------------------------------------------------------

SELECT
    employee_id,
    employee_name,
    job_role
FROM employees
WHERE manager_id IS NULL;


-- ------------------------------------------------------------
-- 2. Find employees who have a manager
-- ------------------------------------------------------------

SELECT
    employee_id,
    employee_name,
    manager_id
FROM employees
WHERE manager_id IS NOT NULL;


-- ------------------------------------------------------------
-- 3. Count employees without managers
-- ------------------------------------------------------------

SELECT
    COUNT(*) AS employees_without_manager
FROM employees
WHERE manager_id IS NULL;


-- ------------------------------------------------------------
-- 4. Count employees with managers
-- ------------------------------------------------------------

SELECT
    COUNT(*) AS employees_with_manager
FROM employees
WHERE manager_id IS NOT NULL;


-- ------------------------------------------------------------
-- 5. Replace NULL manager IDs using COALESCE
-- ------------------------------------------------------------

SELECT
    employee_name,
    COALESCE(manager_id, 0) AS manager_id
FROM employees;


-- ------------------------------------------------------------
-- 6. Create readable hierarchy information
-- ------------------------------------------------------------

SELECT
    employee_name,
    job_role,
    COALESCE(
        CAST(manager_id AS CHAR),
        'No Manager'
    ) AS manager_information
FROM employees;


-- ------------------------------------------------------------
-- 7. Replace NULL using MySQL IFNULL
-- ------------------------------------------------------------

SELECT
    employee_name,
    IFNULL(manager_id, 0) AS safe_manager_id
FROM employees;


-- ------------------------------------------------------------
-- 8. Compare COALESCE and IFNULL
-- ------------------------------------------------------------

SELECT
    employee_name,
    manager_id,

    COALESCE(manager_id, 0)
        AS using_coalesce,

    IFNULL(manager_id, 0)
        AS using_ifnull

FROM employees;


-- ------------------------------------------------------------
-- 9. Use COALESCE with several fallback values
-- ------------------------------------------------------------

SELECT
    student_id,
    name,
    COALESCE(
        city,
        department,
        'Unknown'
    ) AS available_information
FROM students;


-- ------------------------------------------------------------
-- 10. Replace missing city values for reporting
-- ------------------------------------------------------------

SELECT
    student_id,
    name,
    COALESCE(city, 'Unknown City') AS city
FROM students;


-- ------------------------------------------------------------
-- 11. Classify NULL values using CASE
-- ------------------------------------------------------------

SELECT
    employee_name,
    manager_id,

    CASE
        WHEN manager_id IS NULL
            THEN 'Top-Level Employee'
        ELSE 'Reports to Manager'
    END AS hierarchy_status

FROM employees;


-- ------------------------------------------------------------
-- 12. Demonstrate NULLIF
-- ------------------------------------------------------------

SELECT
    NULLIF(10, 10) AS equal_values,
    NULLIF(10, 5) AS different_values;


-- ------------------------------------------------------------
-- 13. Convert a specific department value into NULL
-- ------------------------------------------------------------

SELECT
    employee_name,
    department,
    NULLIF(department, 'Management')
        AS department_after_nullif
FROM employees;


-- ------------------------------------------------------------
-- 14. Convert zero into NULL
-- ------------------------------------------------------------

SELECT
    NULLIF(0, 0) AS zero_to_null,
    NULLIF(100, 0) AS nonzero_value;


-- ------------------------------------------------------------
-- 15. Safe division using NULLIF
-- ------------------------------------------------------------

SELECT
    100 / NULLIF(5, 0)
        AS valid_division,

    100 / NULLIF(0, 0)
        AS safe_zero_division;


-- ------------------------------------------------------------
-- 16. COALESCE a NULL calculation back to zero
-- ------------------------------------------------------------

SELECT
    COALESCE(
        100 / NULLIF(0, 0),
        0
    ) AS safe_result;


-- ------------------------------------------------------------
-- 17. Count all employee rows
-- ------------------------------------------------------------

SELECT
    COUNT(*) AS total_employees
FROM employees;


-- ------------------------------------------------------------
-- 18. Count only non-NULL manager IDs
-- ------------------------------------------------------------

SELECT
    COUNT(manager_id) AS employees_with_manager
FROM employees;


-- ------------------------------------------------------------
-- 19. Compare COUNT(*) and COUNT(column)
-- ------------------------------------------------------------

SELECT
    COUNT(*) AS total_rows,
    COUNT(manager_id) AS non_null_manager_ids,
    COUNT(*) - COUNT(manager_id)
        AS null_manager_ids
FROM employees;


-- ------------------------------------------------------------
-- 20. Calculate percentage of employees without managers
-- ------------------------------------------------------------

SELECT
    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN manager_id IS NULL THEN 1
                ELSE 0
            END
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS no_manager_percentage
FROM employees;


-- ------------------------------------------------------------
-- 21. NULL-safe department report
-- ------------------------------------------------------------

SELECT
    COALESCE(department, 'Unknown Department')
        AS department,

    COUNT(*) AS total_employees

FROM employees
GROUP BY
    COALESCE(department, 'Unknown Department');


-- ------------------------------------------------------------
-- 22. NULL-safe student city report
-- ------------------------------------------------------------

SELECT
    COALESCE(city, 'Unknown City') AS city,
    COUNT(*) AS total_students
FROM students
GROUP BY
    COALESCE(city, 'Unknown City')
ORDER BY total_students DESC;


-- ------------------------------------------------------------
-- 23. Count known and unknown manager relationships
-- ------------------------------------------------------------

SELECT
    SUM(
        CASE
            WHEN manager_id IS NULL THEN 1
            ELSE 0
        END
    ) AS unknown_manager_relationships,

    SUM(
        CASE
            WHEN manager_id IS NOT NULL THEN 1
            ELSE 0
        END
    ) AS known_manager_relationships

FROM employees;


-- ------------------------------------------------------------
-- 24. Calculate NULL percentage for manager_id
-- ------------------------------------------------------------

SELECT
    COUNT(*) AS total_rows,

    COUNT(manager_id)
        AS populated_manager_ids,

    COUNT(*) - COUNT(manager_id)
        AS missing_manager_ids,

    ROUND(
        100.0 *
        (COUNT(*) - COUNT(manager_id))
        / NULLIF(COUNT(*), 0),
        2
    ) AS missing_percentage

FROM employees;


-- ------------------------------------------------------------
-- 25. Display hierarchy with fallback labels
-- ------------------------------------------------------------

SELECT
    e.employee_name,

    COALESCE(
        m.employee_name,
        'No Manager'
    ) AS manager_name

FROM employees AS e

LEFT JOIN employees AS m
    ON e.manager_id = m.employee_id;


-- ------------------------------------------------------------
-- 26. Detect missing project relationships
-- ------------------------------------------------------------

SELECT
    s.student_id,
    s.name,

    CASE
        WHEN p.student_id IS NULL
            THEN 'No Project Assigned'
        ELSE 'Project Assigned'
    END AS project_assignment

FROM students AS s

LEFT JOIN student_projects AS p
    ON s.student_id = p.student_id;


-- ------------------------------------------------------------
-- 27. Replace missing project information
-- ------------------------------------------------------------

SELECT
    s.name,

    COALESCE(
        p.project_name,
        'No Project'
    ) AS project_name

FROM students AS s

LEFT JOIN student_projects AS p
    ON s.student_id = p.student_id;


-- ------------------------------------------------------------
-- 28. NULL-safe average calculation
-- ------------------------------------------------------------

SELECT
    department,

    COALESCE(
        ROUND(AVG(salary), 2),
        0
    ) AS average_salary

FROM employees
GROUP BY department;


-- ------------------------------------------------------------
-- 29. Data-quality summary
-- ------------------------------------------------------------

SELECT
    COUNT(*) AS total_employee_records,

    SUM(
        CASE
            WHEN employee_name IS NULL THEN 1
            ELSE 0
        END
    ) AS missing_names,

    SUM(
        CASE
            WHEN department IS NULL THEN 1
            ELSE 0
        END
    ) AS missing_departments,

    SUM(
        CASE
            WHEN salary IS NULL THEN 1
            ELSE 0
        END
    ) AS missing_salaries,

    SUM(
        CASE
            WHEN manager_id IS NULL THEN 1
            ELSE 0
        END
    ) AS missing_manager_ids

FROM employees;


-- ------------------------------------------------------------
-- 30. Final NULL-safe employee report
-- ------------------------------------------------------------

SELECT
    e.employee_id,

    COALESCE(
        e.employee_name,
        'Unknown Employee'
    ) AS employee_name,

    COALESCE(
        e.department,
        'Unknown Department'
    ) AS department,

    COALESCE(
        e.job_role,
        'Role Not Available'
    ) AS job_role,

    COALESCE(
        e.salary,
        0
    ) AS salary,

    COALESCE(
        m.employee_name,
        'No Manager'
    ) AS manager,

    CASE
        WHEN e.manager_id IS NULL
            THEN 'Top-Level Employee'
        ELSE 'Reports to Manager'
    END AS hierarchy_status

FROM employees AS e

LEFT JOIN employees AS m
    ON e.manager_id = m.employee_id

ORDER BY e.employee_id;