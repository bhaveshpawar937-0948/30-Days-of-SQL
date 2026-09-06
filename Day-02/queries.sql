-- ============================================================
-- 30 Days of SQL
-- Day 02: SELECT Statements & Data Retrieval
-- Author: Bhavesh Pawar
-- ============================================================

USE sql_30_days;


-- ------------------------------------------------------------
-- Setup sample data
-- Run this section if the students table is empty
-- ------------------------------------------------------------

INSERT INTO students (student_id, name, age, department, city)
VALUES
(1, 'Rahul', 21, 'Computer Science', 'Mumbai'),
(2, 'Priya', 20, 'Artificial Intelligence', 'Pune'),
(3, 'Aman', 22, 'Data Science', 'Mumbai'),
(4, 'Sneha', 21, 'Artificial Intelligence', 'Navi Mumbai'),
(5, 'Rohan', 23, 'Computer Science', 'Pune'),
(6, 'Neha', 20, 'Data Science', 'Navi Mumbai');


-- ------------------------------------------------------------
-- 1. Retrieve all columns and rows
-- ------------------------------------------------------------

SELECT *
FROM students;


-- ------------------------------------------------------------
-- 2. Retrieve a single column
-- ------------------------------------------------------------

SELECT name
FROM students;


-- ------------------------------------------------------------
-- 3. Retrieve multiple columns
-- ------------------------------------------------------------

SELECT name, age
FROM students;


-- ------------------------------------------------------------
-- 4. Retrieve student name and department
-- ------------------------------------------------------------

SELECT name, department
FROM students;


-- ------------------------------------------------------------
-- 5. Display unique departments
-- ------------------------------------------------------------

SELECT DISTINCT department
FROM students;


-- ------------------------------------------------------------
-- 6. Display unique cities
-- ------------------------------------------------------------

SELECT DISTINCT city
FROM students;


-- ------------------------------------------------------------
-- 7. Rename columns using aliases
-- ------------------------------------------------------------

SELECT
    name AS student_name,
    department AS student_department
FROM students;


-- ------------------------------------------------------------
-- 8. Use aliases without the AS keyword
-- ------------------------------------------------------------

SELECT
    name student_name,
    city student_city
FROM students;


-- ------------------------------------------------------------
-- 9. Create a calculated column
-- ------------------------------------------------------------

SELECT
    name,
    age,
    age + 1 AS age_next_year
FROM students;


-- ------------------------------------------------------------
-- 10. Combine retrieved information with text
-- MySQL CONCAT() example
-- ------------------------------------------------------------

SELECT
    CONCAT(name, ' - ', department) AS student_details
FROM students;


-- ------------------------------------------------------------
-- 11. Retrieve selected columns with clear headings
-- ------------------------------------------------------------

SELECT
    student_id AS id,
    name AS student_name,
    age AS student_age,
    department
FROM students;


-- ------------------------------------------------------------
-- 12. Limit the number of returned rows
-- ------------------------------------------------------------

SELECT *
FROM students
LIMIT 3;


-- ------------------------------------------------------------
-- 13. Retrieve only names and cities
-- ------------------------------------------------------------

SELECT name, city
FROM students;


-- ------------------------------------------------------------
-- 14. Find all unique combinations of department and city
-- ------------------------------------------------------------

SELECT DISTINCT department, city
FROM students;


-- ------------------------------------------------------------
-- 15. Simple arithmetic calculation
-- ------------------------------------------------------------

SELECT
    name,
    age,
    age * 12 AS approximate_age_in_months
FROM students;
