-- ============================================================
-- 30 Days of SQL
-- Day 11: UNION & UNION ALL
-- Author: Bhavesh Pawar
-- ============================================================

USE sql_30_days;


-- ------------------------------------------------------------
-- Setup: Create alumni students table
-- ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS alumni_students (
    alumni_id INT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(100),
    city VARCHAR(100),
    graduation_year INT
);


-- ------------------------------------------------------------
-- Insert sample alumni data
-- ------------------------------------------------------------

INSERT IGNORE INTO alumni_students
    (alumni_id, name, department, city, graduation_year)
VALUES
    (101, 'Aarav', 'Computer Science', 'Mumbai', 2023),
    (102, 'Priya', 'Artificial Intelligence', 'Pune', 2024),
    (103, 'Meera', 'Data Science', 'Navi Mumbai', 2022),
    (104, 'Rahul', 'Computer Science', 'Mumbai', 2024),
    (105, 'Karan', 'Artificial Intelligence', 'Pune', 2023);


-- ------------------------------------------------------------
-- 1. Combine student names using UNION
-- Duplicate names are removed
-- ------------------------------------------------------------

SELECT name
FROM students

UNION

SELECT name
FROM alumni_students;


-- ------------------------------------------------------------
-- 2. Combine student names using UNION ALL
-- Duplicate names are preserved
-- ------------------------------------------------------------

SELECT name
FROM students

UNION ALL

SELECT name
FROM alumni_students;


-- ------------------------------------------------------------
-- 3. Combine names and cities
-- ------------------------------------------------------------

SELECT
    name,
    city
FROM students

UNION

SELECT
    name,
    city
FROM alumni_students;


-- ------------------------------------------------------------
-- 4. Preserve every name-city record
-- ------------------------------------------------------------

SELECT
    name,
    city
FROM students

UNION ALL

SELECT
    name,
    city
FROM alumni_students;


-- ------------------------------------------------------------
-- 5. Combine names and departments
-- ------------------------------------------------------------

SELECT
    name,
    department
FROM students

UNION

SELECT
    name,
    department
FROM alumni_students;


-- ------------------------------------------------------------
-- 6. Add source labels
-- ------------------------------------------------------------

SELECT
    name,
    department,
    'Current Student' AS source
FROM students

UNION ALL

SELECT
    name,
    department,
    'Alumni' AS source
FROM alumni_students;


-- ------------------------------------------------------------
-- 7. Create a unified student directory
-- ------------------------------------------------------------

SELECT
    name,
    department,
    city,
    'Current' AS student_type
FROM students

UNION ALL

SELECT
    name,
    department,
    city,
    'Alumni' AS student_type
FROM alumni_students;


-- ------------------------------------------------------------
-- 8. Sort the final UNION result alphabetically
-- ------------------------------------------------------------

SELECT name
FROM students

UNION

SELECT name
FROM alumni_students

ORDER BY name;


-- ------------------------------------------------------------
-- 9. Sort combined names and cities
-- ------------------------------------------------------------

SELECT
    name,
    city
FROM students

UNION ALL

SELECT
    name,
    city
FROM alumni_students

ORDER BY city, name;


-- ------------------------------------------------------------
-- 10. Combine Mumbai students from both datasets
-- ------------------------------------------------------------

SELECT
    name,
    city,
    'Current' AS source
FROM students
WHERE city = 'Mumbai'

UNION ALL

SELECT
    name,
    city,
    'Alumni' AS source
FROM alumni_students
WHERE city = 'Mumbai';


-- ------------------------------------------------------------
-- 11. Combine Artificial Intelligence students
-- ------------------------------------------------------------

SELECT
    name,
    department,
    'Current' AS source
FROM students
WHERE department = 'Artificial Intelligence'

UNION ALL

SELECT
    name,
    department,
    'Alumni' AS source
FROM alumni_students
WHERE department = 'Artificial Intelligence';


-- ------------------------------------------------------------
-- 12. Demonstrate duplicate removal
-- Priya and Rahul may exist in both datasets
-- ------------------------------------------------------------

SELECT name
FROM students
WHERE name IN ('Priya', 'Rahul')

UNION

SELECT name
FROM alumni_students
WHERE name IN ('Priya', 'Rahul');


-- ------------------------------------------------------------
-- 13. Demonstrate duplicate preservation
-- ------------------------------------------------------------

SELECT name
FROM students
WHERE name IN ('Priya', 'Rahul')

UNION ALL

SELECT name
FROM alumni_students
WHERE name IN ('Priya', 'Rahul');


-- ------------------------------------------------------------
-- 14. Combine city lists and remove duplicates
-- ------------------------------------------------------------

SELECT city
FROM students

UNION

SELECT city
FROM alumni_students;


-- ------------------------------------------------------------
-- 15. Preserve every city occurrence
-- ------------------------------------------------------------

SELECT city
FROM students

UNION ALL

SELECT city
FROM alumni_students;


-- ------------------------------------------------------------
-- 16. Combine department lists
-- ------------------------------------------------------------

SELECT department
FROM students

UNION

SELECT department
FROM alumni_students

ORDER BY department;


-- ------------------------------------------------------------
-- 17. Combine records with compatible calculated columns
-- ------------------------------------------------------------

SELECT
    name,
    0 AS graduation_year
FROM students

UNION ALL

SELECT
    name,
    graduation_year
FROM alumni_students;


-- ------------------------------------------------------------
-- 18. Create one combined dataset with readable status
-- ------------------------------------------------------------

SELECT
    name,
    department,
    city,
    'Currently Studying' AS status
FROM students

UNION ALL

SELECT
    name,
    department,
    city,
    CONCAT('Graduated ', graduation_year) AS status
FROM alumni_students;


-- ------------------------------------------------------------
-- 19. Count rows after UNION
-- Duplicates are removed before counting
-- ------------------------------------------------------------

SELECT COUNT(*) AS unique_names
FROM (
    SELECT name
    FROM students

    UNION

    SELECT name
    FROM alumni_students
) AS combined_students;


-- ------------------------------------------------------------
-- 20. Count rows after UNION ALL
-- Every row is preserved
-- ------------------------------------------------------------

SELECT COUNT(*) AS total_records
FROM (
    SELECT name
    FROM students

    UNION ALL

    SELECT name
    FROM alumni_students
) AS combined_students;


-- ------------------------------------------------------------
-- 21. Final unified student and alumni report
-- ------------------------------------------------------------

SELECT
    name,
    department,
    city,
    'Current Student' AS category
FROM students

UNION ALL

SELECT
    name,
    department,
    city,
    CONCAT('Alumni - ', graduation_year) AS category
FROM alumni_students

ORDER BY department, name;