-- ============================================================
-- 30 Days of SQL
-- Day 08: LEFT JOIN & Unmatched Records
-- Author: Bhavesh Pawar
-- ============================================================

USE sql_30_days;


-- ------------------------------------------------------------
-- Setup: Create a related projects table
-- Some students intentionally have no project
-- ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS student_projects (
    project_id INT PRIMARY KEY,
    student_id INT,
    project_name VARCHAR(150),
    project_status VARCHAR(50),
    FOREIGN KEY (student_id)
        REFERENCES students(student_id)
);


-- ------------------------------------------------------------
-- Insert sample project data
-- INSERT IGNORE prevents duplicate primary-key errors
-- if this script is executed again
-- ------------------------------------------------------------

INSERT IGNORE INTO student_projects
    (project_id, student_id, project_name, project_status)
VALUES
    (101, 1, 'Sales Dashboard', 'Completed'),
    (102, 2, 'Customer Churn Prediction', 'In Progress'),
    (103, 3, 'E-Commerce Analytics', 'Completed'),
    (104, 5, 'Inventory Analysis', 'In Progress');


-- ------------------------------------------------------------
-- 1. Basic LEFT JOIN
-- Keep every student
-- ------------------------------------------------------------

SELECT
    s.student_id,
    s.name,
    p.project_name
FROM students AS s
LEFT JOIN student_projects AS p
    ON s.student_id = p.student_id;


-- ------------------------------------------------------------
-- 2. Display student and complete project details
-- ------------------------------------------------------------

SELECT
    s.student_id,
    s.name,
    s.department,
    p.project_name,
    p.project_status
FROM students AS s
LEFT JOIN student_projects AS p
    ON s.student_id = p.student_id;


-- ------------------------------------------------------------
-- 3. Observe unmatched rows
-- Students without projects will contain NULL
-- ------------------------------------------------------------

SELECT
    s.name,
    p.project_name,
    p.project_status
FROM students AS s
LEFT JOIN student_projects AS p
    ON s.student_id = p.student_id;


-- ------------------------------------------------------------
-- 4. Find students with NO assigned project
-- Anti-join pattern
-- ------------------------------------------------------------

SELECT
    s.student_id,
    s.name,
    s.department
FROM students AS s
LEFT JOIN student_projects AS p
    ON s.student_id = p.student_id
WHERE p.project_id IS NULL;


-- ------------------------------------------------------------
-- 5. Find students who HAVE an assigned project
-- ------------------------------------------------------------

SELECT
    s.student_id,
    s.name,
    p.project_name
FROM students AS s
LEFT JOIN student_projects AS p
    ON s.student_id = p.student_id
WHERE p.project_id IS NOT NULL;


-- ------------------------------------------------------------
-- 6. Find students without completed projects
-- This includes students with no project assignment
-- ------------------------------------------------------------

SELECT
    s.name,
    p.project_name,
    p.project_status
FROM students AS s
LEFT JOIN student_projects AS p
    ON s.student_id = p.student_id
WHERE p.project_status <> 'Completed'
   OR p.project_status IS NULL;


-- ------------------------------------------------------------
-- 7. Find students without projects from a specific department
-- ------------------------------------------------------------

SELECT
    s.name,
    s.department
FROM students AS s
LEFT JOIN student_projects AS p
    ON s.student_id = p.student_id
WHERE p.project_id IS NULL
  AND s.department = 'Artificial Intelligence';


-- ------------------------------------------------------------
-- 8. Show student city alongside project information
-- ------------------------------------------------------------

SELECT
    s.name,
    s.city,
    p.project_name,
    p.project_status
FROM students AS s
LEFT JOIN student_projects AS p
    ON s.student_id = p.student_id;


-- ------------------------------------------------------------
-- 9. Display only projects that are currently in progress
-- while using the joined relationship
-- ------------------------------------------------------------

SELECT
    s.name,
    p.project_name,
    p.project_status
FROM students AS s
LEFT JOIN student_projects AS p
    ON s.student_id = p.student_id
WHERE p.project_status = 'In Progress';


-- ------------------------------------------------------------
-- 10. Identify students with missing project relationships
-- Useful for data quality checks
-- ------------------------------------------------------------

SELECT
    s.student_id,
    s.name,
    'No project assigned' AS issue
FROM students AS s
LEFT JOIN student_projects AS p
    ON s.student_id = p.student_id
WHERE p.student_id IS NULL;


-- ------------------------------------------------------------
-- 11. Show every student and matching project ID
-- ------------------------------------------------------------

SELECT
    s.student_id,
    s.name,
    p.project_id,
    p.project_name
FROM students AS s
LEFT JOIN student_projects AS p
    ON s.student_id = p.student_id;


-- ------------------------------------------------------------
-- 12. Find students who have completed a project
-- ------------------------------------------------------------

SELECT
    s.name,
    p.project_name
FROM students AS s
LEFT JOIN student_projects AS p
    ON s.student_id = p.student_id
WHERE p.project_status = 'Completed';


-- ------------------------------------------------------------
-- 13. Compare the student ID from both tables
-- NULL on the project side reveals missing matches
-- ------------------------------------------------------------

SELECT
    s.student_id AS student_table_id,
    p.student_id AS project_table_student_id,
    s.name,
    p.project_name
FROM students AS s
LEFT JOIN student_projects AS p
    ON s.student_id = p.student_id;


-- ------------------------------------------------------------
-- 14. Return only unmatched student names
-- ------------------------------------------------------------

SELECT
    s.name
FROM students AS s
LEFT JOIN student_projects AS p
    ON s.student_id = p.student_id
WHERE p.student_id IS NULL;


-- ------------------------------------------------------------
-- 15. Produce a project-assignment report
-- ------------------------------------------------------------

SELECT
    s.student_id,
    s.name,
    s.department,
    s.city,
    p.project_name,
    p.project_status
FROM students AS s
LEFT JOIN student_projects AS p
    ON s.student_id = p.student_id
ORDER BY s.student_id;