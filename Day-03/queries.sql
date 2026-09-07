-- ============================================================
-- 30 Days of SQL
-- Day 03: Filtering Data with WHERE
-- Author: Bhavesh Pawar
-- ============================================================

USE sql_30_days;


-- ------------------------------------------------------------
-- 1. Display all students
-- ------------------------------------------------------------

SELECT *
FROM students;


-- ------------------------------------------------------------
-- 2. Find students who are 21 years old
-- ------------------------------------------------------------

SELECT *
FROM students
WHERE age = 21;


-- ------------------------------------------------------------
-- 3. Find students older than 20
-- ------------------------------------------------------------

SELECT *
FROM students
WHERE age > 20;


-- ------------------------------------------------------------
-- 4. Find students younger than 22
-- ------------------------------------------------------------

SELECT *
FROM students
WHERE age < 22;


-- ------------------------------------------------------------
-- 5. Find students aged 21 or older
-- ------------------------------------------------------------

SELECT *
FROM students
WHERE age >= 21;


-- ------------------------------------------------------------
-- 6. Find students aged 21 or younger
-- ------------------------------------------------------------

SELECT *
FROM students
WHERE age <= 21;


-- ------------------------------------------------------------
-- 7. Find students whose city is not Mumbai
-- ------------------------------------------------------------

SELECT *
FROM students
WHERE city <> 'Mumbai';


-- ------------------------------------------------------------
-- 8. Filter students using AND
-- Students aged 21 or older who live in Mumbai
-- ------------------------------------------------------------

SELECT *
FROM students
WHERE age >= 21
AND city = 'Mumbai';


-- ------------------------------------------------------------
-- 9. Filter using OR
-- Students from Mumbai or Pune
-- ------------------------------------------------------------

SELECT *
FROM students
WHERE city = 'Mumbai'
OR city = 'Pune';


-- ------------------------------------------------------------
-- 10. Exclude students from Mumbai
-- ------------------------------------------------------------

SELECT *
FROM students
WHERE NOT city = 'Mumbai';


-- ------------------------------------------------------------
-- 11. Find students aged between 20 and 22
-- ------------------------------------------------------------

SELECT *
FROM students
WHERE age BETWEEN 20 AND 22;


-- ------------------------------------------------------------
-- 12. Find students outside the age range 20 to 22
-- ------------------------------------------------------------

SELECT *
FROM students
WHERE age NOT BETWEEN 20 AND 22;


-- ------------------------------------------------------------
-- 13. Find students from selected cities using IN
-- ------------------------------------------------------------

SELECT *
FROM students
WHERE city IN ('Mumbai', 'Pune');


-- ------------------------------------------------------------
-- 14. Exclude selected cities
-- ------------------------------------------------------------

SELECT *
FROM students
WHERE city NOT IN ('Mumbai', 'Pune');


-- ------------------------------------------------------------
-- 15. Find students whose names start with R
-- ------------------------------------------------------------

SELECT *
FROM students
WHERE name LIKE 'R%';


-- ------------------------------------------------------------
-- 16. Find students whose names end with a
-- ------------------------------------------------------------

SELECT *
FROM students
WHERE name LIKE '%a';


-- ------------------------------------------------------------
-- 17. Find names containing the letter e
-- ------------------------------------------------------------

SELECT *
FROM students
WHERE name LIKE '%e%';


-- ------------------------------------------------------------
-- 18. Find names with exactly five characters
-- ------------------------------------------------------------

SELECT *
FROM students
WHERE name LIKE '_____';


-- ------------------------------------------------------------
-- 19. Find students from Artificial Intelligence department
-- ------------------------------------------------------------

SELECT *
FROM students
WHERE department = 'Artificial Intelligence';


-- ------------------------------------------------------------
-- 20. Combine AND with IN
-- Find students aged at least 21 from Mumbai or Pune
-- ------------------------------------------------------------

SELECT *
FROM students
WHERE age >= 21
AND city IN ('Mumbai', 'Pune');


-- ------------------------------------------------------------
-- 21. Combine AND and OR using brackets
-- ------------------------------------------------------------

SELECT *
FROM students
WHERE age >= 21
AND (city = 'Mumbai' OR city = 'Pune');


-- ------------------------------------------------------------
-- 22. Filter selected columns only
-- ------------------------------------------------------------

SELECT name, age, city
FROM students
WHERE age > 20;


-- ------------------------------------------------------------
-- 23. Find Computer Science students from Pune
-- ------------------------------------------------------------

SELECT *
FROM students
WHERE department = 'Computer Science'
AND city = 'Pune';


-- ------------------------------------------------------------
-- 24. Find Data Science or Artificial Intelligence students
-- ------------------------------------------------------------

SELECT *
FROM students
WHERE department IN (
    'Data Science',
    'Artificial Intelligence'
);


-- ------------------------------------------------------------
-- 25. Find students whose names do not start with R
-- ------------------------------------------------------------

SELECT *
FROM students
WHERE name NOT LIKE 'R%';
