-- ============================================================
-- 30 Days of SQL
-- Day 08: RIGHT JOIN & Join Direction
-- Author: Bhavesh Pawar
-- ============================================================

USE sql_30_days;


-- ------------------------------------------------------------
-- 1. Basic RIGHT JOIN
-- Preserve every student
-- ------------------------------------------------------------

SELECT
    s.student_id,
    s.name,
    p.project_name
FROM student_projects AS p
RIGHT JOIN students AS s
    ON p.student_id = s.student_id;


-- ------------------------------------------------------------
-- 2. Display complete student and project information
-- ------------------------------------------------------------

SELECT
    s.student_id,
    s.name,
    s.department,
    s.city,
    p.project_id,
    p.project_name,
    p.project_status
FROM student_projects AS p
RIGHT JOIN students AS s
    ON p.student_id = s.student_id;


-- ------------------------------------------------------------
-- 3. Observe unmatched right-side rows
-- Students without projects produce NULL project values
-- ------------------------------------------------------------

SELECT
    s.name,
    p.project_name,
    p.project_status
FROM student_projects AS p
RIGHT JOIN students AS s
    ON p.student_id = s.student_id;


-- ------------------------------------------------------------
-- 4. Find students without a project
-- ------------------------------------------------------------

SELECT
    s.student_id,
    s.name,
    s.department
FROM student_projects AS p
RIGHT JOIN students AS s
    ON p.student_id = s.student_id
WHERE p.project_id IS NULL;


-- ------------------------------------------------------------
-- 5. Find students who have a project
-- ------------------------------------------------------------

SELECT
    s.student_id,
    s.name,
    p.project_name
FROM student_projects AS p
RIGHT JOIN students AS s
    ON p.student_id = s.student_id
WHERE p.project_id IS NOT NULL;


-- ------------------------------------------------------------
-- 6. Display right-table and left-table IDs together
-- ------------------------------------------------------------

SELECT
    s.student_id AS student_table_id,
    p.student_id AS project_table_student_id,
    s.name,
    p.project_name
FROM student_projects AS p
RIGHT JOIN students AS s
    ON p.student_id = s.student_id;


-- ------------------------------------------------------------
-- 7. Identify missing project relationships
-- ------------------------------------------------------------

SELECT
    s.student_id,
    s.name,
    'No project assigned' AS project_status
FROM student_projects AS p
RIGHT JOIN students AS s
    ON p.student_id = s.student_id
WHERE p.student_id IS NULL;


-- ------------------------------------------------------------
-- 8. Show all students with project status
-- ------------------------------------------------------------

SELECT
    s.name,
    s.department,
    p.project_name,
    p.project_status
FROM student_projects AS p
RIGHT JOIN students AS s
    ON p.student_id = s.student_id
ORDER BY s.student_id;


-- ------------------------------------------------------------
-- 9. Show only students with completed projects
-- ------------------------------------------------------------

SELECT
    s.name,
    p.project_name,
    p.project_status
FROM student_projects AS p
RIGHT JOIN students AS s
    ON p.student_id = s.student_id
WHERE p.project_status = 'Completed';


-- ------------------------------------------------------------
-- 10. Show students with projects still in progress
-- ------------------------------------------------------------

SELECT
    s.name,
    p.project_name,
    p.project_status
FROM student_projects AS p
RIGHT JOIN students AS s
    ON p.student_id = s.student_id
WHERE p.project_status = 'In Progress';


-- ------------------------------------------------------------
-- 11. Find students with no project from Mumbai
-- ------------------------------------------------------------

SELECT
    s.student_id,
    s.name,
    s.city
FROM student_projects AS p
RIGHT JOIN students AS s
    ON p.student_id = s.student_id
WHERE p.project_id IS NULL
  AND s.city = 'Mumbai';


-- ------------------------------------------------------------
-- 12. Create a complete assignment report
-- ------------------------------------------------------------

SELECT
    s.student_id,
    s.name,
    s.department,
    s.city,
    p.project_name,
    p.project_status
FROM student_projects AS p
RIGHT JOIN students AS s
    ON p.student_id = s.student_id
ORDER BY s.name;


-- ------------------------------------------------------------
-- 13. RIGHT JOIN written to preserve all students
-- ------------------------------------------------------------

SELECT
    s.name,
    p.project_name
FROM student_projects AS p
RIGHT JOIN students AS s
    ON p.student_id = s.student_id;


-- ------------------------------------------------------------
-- 14. Equivalent LEFT JOIN
-- Same logical result after reversing table order
-- ------------------------------------------------------------

SELECT
    s.name,
    p.project_name
FROM students AS s
LEFT JOIN student_projects AS p
    ON s.student_id = p.student_id;


-- ------------------------------------------------------------
-- 15. Compare project availability for every student
-- ------------------------------------------------------------

SELECT
    s.name,
    CASE
        WHEN p.project_id IS NULL THEN 'No Project'
        ELSE 'Project Assigned'
    END AS assignment_status
FROM student_projects AS p
RIGHT JOIN students AS s
    ON p.student_id = s.student_id
ORDER BY s.student_id;


-- ------------------------------------------------------------
-- 16. Create a readable project report using COALESCE
-- ------------------------------------------------------------

SELECT
    s.name,
    COALESCE(p.project_name, 'No Project Assigned') AS project_name
FROM student_projects AS p
RIGHT JOIN students AS s
    ON p.student_id = s.student_id
ORDER BY s.name;


-- ------------------------------------------------------------
-- 17. Show project status with missing values replaced
-- ------------------------------------------------------------

SELECT
    s.name,
    COALESCE(p.project_status, 'Not Assigned') AS project_status
FROM student_projects AS p
RIGHT JOIN students AS s
    ON p.student_id = s.student_id;


-- ------------------------------------------------------------
-- 18. Show students and project details for AI department
-- ------------------------------------------------------------

SELECT
    s.name,
    s.department,
    p.project_name
FROM student_projects AS p
RIGHT JOIN students AS s
    ON p.student_id = s.student_id
WHERE s.department = 'Artificial Intelligence';


-- ------------------------------------------------------------
-- 19. Report students without completed project assignments
-- ------------------------------------------------------------

SELECT
    s.name,
    COALESCE(p.project_name, 'No Project') AS project_name,
    COALESCE(p.project_status, 'Not Assigned') AS project_status
FROM student_projects AS p
RIGHT JOIN students AS s
    ON p.student_id = s.student_id
WHERE p.project_status <> 'Completed'
   OR p.project_status IS NULL;


-- ------------------------------------------------------------
-- 20. Final RIGHT JOIN student-project report
-- ------------------------------------------------------------

SELECT
    s.student_id,
    s.name,
    s.department,
    s.city,
    COALESCE(p.project_name, 'No Project Assigned') AS project,
    COALESCE(p.project_status, 'Not Assigned') AS status
FROM student_projects AS p
RIGHT JOIN students AS s
    ON p.student_id = s.student_id
ORDER BY s.student_id;