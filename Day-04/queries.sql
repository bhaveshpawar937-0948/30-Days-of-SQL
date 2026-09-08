-- ============================================================
-- 30 Days of SQL
-- Day 04: Sorting & Limiting Data
-- Author: Bhavesh Pawar
-- ============================================================

USE sql_30_days;


-- ------------------------------------------------------------
-- 1. Display all students
-- ------------------------------------------------------------

SELECT *
FROM students;


-- ------------------------------------------------------------
-- 2. Sort students by age in ascending order
-- ------------------------------------------------------------

SELECT *
FROM students
ORDER BY age ASC;


-- ------------------------------------------------------------
-- 3. Sort students by age in descending order
-- ------------------------------------------------------------

SELECT *
FROM students
ORDER BY age DESC;


-- ------------------------------------------------------------
-- 4. Sort student names alphabetically
-- ------------------------------------------------------------

SELECT *
FROM students
ORDER BY name ASC;


-- ------------------------------------------------------------
-- 5. Sort student names in reverse alphabetical order
-- ------------------------------------------------------------

SELECT *
FROM students
ORDER BY name DESC;


-- ------------------------------------------------------------
-- 6. Sort students by city
-- ------------------------------------------------------------

SELECT *
FROM students
ORDER BY city ASC;


-- ------------------------------------------------------------
-- 7. Sort students by department
-- ------------------------------------------------------------

SELECT *
FROM students
ORDER BY department ASC;


-- ------------------------------------------------------------
-- 8. Sort using multiple columns
-- First by department, then by age
-- ------------------------------------------------------------

SELECT *
FROM students
ORDER BY department ASC, age ASC;


-- ------------------------------------------------------------
-- 9. Sort by department and then age descending
-- ------------------------------------------------------------

SELECT *
FROM students
ORDER BY department ASC, age DESC;


-- ------------------------------------------------------------
-- 10. Sort by city and then student name
-- ------------------------------------------------------------

SELECT *
FROM students
ORDER BY city ASC, name ASC;


-- ------------------------------------------------------------
-- 11. Filter and sort
-- Students older than 20, sorted by age
-- ------------------------------------------------------------

SELECT *
FROM students
WHERE age > 20
ORDER BY age ASC;


-- ------------------------------------------------------------
-- 12. Filter and sort in descending order
-- ------------------------------------------------------------

SELECT *
FROM students
WHERE age >= 21
ORDER BY age DESC;


-- ------------------------------------------------------------
-- 13. Filter students from selected cities and sort by name
-- ------------------------------------------------------------

SELECT *
FROM students
WHERE city IN ('Mumbai', 'Pune')
ORDER BY name ASC;


-- ------------------------------------------------------------
-- 14. Display only the first 3 students
-- ------------------------------------------------------------

SELECT *
FROM students
LIMIT 3;


-- ------------------------------------------------------------
-- 15. Display the two oldest students
-- ------------------------------------------------------------

SELECT *
FROM students
ORDER BY age DESC
LIMIT 2;


-- ------------------------------------------------------------
-- 16. Display the two youngest students
-- ------------------------------------------------------------

SELECT *
FROM students
ORDER BY age ASC
LIMIT 2;


-- ------------------------------------------------------------
-- 17. Display the first three names alphabetically
-- ------------------------------------------------------------

SELECT name
FROM students
ORDER BY name ASC
LIMIT 3;


-- ------------------------------------------------------------
-- 18. Display the last three names alphabetically
-- ------------------------------------------------------------

SELECT name
FROM students
ORDER BY name DESC
LIMIT 3;


-- ------------------------------------------------------------
-- 19. Return students after skipping the first two rows
-- ------------------------------------------------------------

SELECT *
FROM students
ORDER BY student_id
LIMIT 3 OFFSET 2;


-- ------------------------------------------------------------
-- 20. Pagination example
-- Page 1: first two records
-- ------------------------------------------------------------

SELECT *
FROM students
ORDER BY student_id
LIMIT 2 OFFSET 0;


-- ------------------------------------------------------------
-- 21. Pagination example
-- Page 2: next two records
-- ------------------------------------------------------------

SELECT *
FROM students
ORDER BY student_id
LIMIT 2 OFFSET 2;


-- ------------------------------------------------------------
-- 22. Pagination example
-- Page 3: next two records
-- ------------------------------------------------------------

SELECT *
FROM students
ORDER BY student_id
LIMIT 2 OFFSET 4;


-- ------------------------------------------------------------
-- 23. Find the oldest student
-- ------------------------------------------------------------

SELECT *
FROM students
ORDER BY age DESC
LIMIT 1;


-- ------------------------------------------------------------
-- 24. Find the youngest student
-- ------------------------------------------------------------

SELECT *
FROM students
ORDER BY age ASC
LIMIT 1;


-- ------------------------------------------------------------
-- 25. Find the oldest student from Mumbai
-- ------------------------------------------------------------

SELECT *
FROM students
WHERE city = 'Mumbai'
ORDER BY age DESC
LIMIT 1;


-- ------------------------------------------------------------
-- 26. Find the youngest Artificial Intelligence student
-- ------------------------------------------------------------

SELECT *
FROM students
WHERE department = 'Artificial Intelligence'
ORDER BY age ASC
LIMIT 1;


-- ------------------------------------------------------------
-- 27. Sort selected columns only
-- ------------------------------------------------------------

SELECT name, age, city
FROM students
ORDER BY age DESC;


-- ------------------------------------------------------------
-- 28. Sort filtered Data Science students
-- ------------------------------------------------------------

SELECT name, age, city
FROM students
WHERE department = 'Data Science'
ORDER BY age DESC;


-- ------------------------------------------------------------
-- 29. Sort by a calculated value
-- ------------------------------------------------------------

SELECT
    name,
    age,
    age * 12 AS approximate_age_in_months
FROM students
ORDER BY approximate_age_in_months DESC;


-- ------------------------------------------------------------
-- 30. Top-N style query
-- Return the 3 oldest students
-- ------------------------------------------------------------

SELECT
    name,
    age,
    department,
    city
FROM students
ORDER BY age DESC
LIMIT 3;
