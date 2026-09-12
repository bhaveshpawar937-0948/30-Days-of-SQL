-- ============================================================
-- 30 Days of SQL
-- Day 06: GROUP BY & HAVING
-- Author: Bhavesh Pawar
-- ============================================================

USE sql_30_days;


-- ------------------------------------------------------------
-- 1. Count students in each department
-- ------------------------------------------------------------

SELECT
    department,
    COUNT(*) AS total_students
FROM student_scores
GROUP BY department;


-- ------------------------------------------------------------
-- 2. Calculate average score for each department
-- ------------------------------------------------------------

SELECT
    department,
    ROUND(AVG(score), 2) AS average_score
FROM student_scores
GROUP BY department;


-- ------------------------------------------------------------
-- 3. Find highest and lowest score in each department
-- ------------------------------------------------------------

SELECT
    department,
    MIN(score) AS lowest_score,
    MAX(score) AS highest_score
FROM student_scores
GROUP BY department;


-- ------------------------------------------------------------
-- 4. Count students in each city
-- ------------------------------------------------------------

SELECT
    city,
    COUNT(*) AS total_students
FROM student_scores
GROUP BY city;


-- ------------------------------------------------------------
-- 5. Calculate average score by city
-- ------------------------------------------------------------

SELECT
    city,
    ROUND(AVG(score), 2) AS average_score
FROM student_scores
GROUP BY city;


-- ------------------------------------------------------------
-- 6. Group using department and city
-- ------------------------------------------------------------

SELECT
    department,
    city,
    COUNT(*) AS total_students
FROM student_scores
GROUP BY department, city;


-- ------------------------------------------------------------
-- 7. Average score for every department-city combination
-- ------------------------------------------------------------

SELECT
    department,
    city,
    ROUND(AVG(score), 2) AS average_score
FROM student_scores
GROUP BY department, city;


-- ------------------------------------------------------------
-- 8. Filter rows before grouping
-- Only students scoring 80 or higher are included
-- ------------------------------------------------------------

SELECT
    department,
    COUNT(*) AS students_scoring_80_plus
FROM student_scores
WHERE score >= 80
GROUP BY department;


-- ------------------------------------------------------------
-- 9. Find departments containing at least 3 students
-- ------------------------------------------------------------

SELECT
    department,
    COUNT(*) AS total_students
FROM student_scores
GROUP BY department
HAVING COUNT(*) >= 3;


-- ------------------------------------------------------------
-- 10. Find departments with an average score above 85
-- ------------------------------------------------------------

SELECT
    department,
    ROUND(AVG(score), 2) AS average_score
FROM student_scores
GROUP BY department
HAVING AVG(score) > 85;


-- ------------------------------------------------------------
-- 11. Find cities with an average score of at least 85
-- ------------------------------------------------------------

SELECT
    city,
    ROUND(AVG(score), 2) AS average_score
FROM student_scores
GROUP BY city
HAVING AVG(score) >= 85;


-- ------------------------------------------------------------
-- 12. Find departments having at least one score of 90+
-- ------------------------------------------------------------

SELECT
    department,
    MAX(score) AS highest_score
FROM student_scores
GROUP BY department
HAVING MAX(score) >= 90;


-- ------------------------------------------------------------
-- 13. Apply multiple HAVING conditions
-- ------------------------------------------------------------

SELECT
    department,
    COUNT(*) AS total_students,
    ROUND(AVG(score), 2) AS average_score
FROM student_scores
GROUP BY department
HAVING COUNT(*) >= 3
   AND AVG(score) >= 80;


-- ------------------------------------------------------------
-- 14. Rank departments by average score
-- ------------------------------------------------------------

SELECT
    department,
    ROUND(AVG(score), 2) AS average_score
FROM student_scores
GROUP BY department
ORDER BY average_score DESC;


-- ------------------------------------------------------------
-- 15. Rank cities by number of students
-- ------------------------------------------------------------

SELECT
    city,
    COUNT(*) AS total_students
FROM student_scores
GROUP BY city
ORDER BY total_students DESC;


-- ------------------------------------------------------------
-- 16. Department performance summary
-- ------------------------------------------------------------

SELECT
    department,
    COUNT(*) AS total_students,
    ROUND(AVG(score), 2) AS average_score,
    MIN(score) AS lowest_score,
    MAX(score) AS highest_score
FROM student_scores
GROUP BY department
ORDER BY average_score DESC;


-- ------------------------------------------------------------
-- 17. City performance summary
-- ------------------------------------------------------------

SELECT
    city,
    COUNT(*) AS total_students,
    ROUND(AVG(score), 2) AS average_score,
    MIN(score) AS lowest_score,
    MAX(score) AS highest_score
FROM student_scores
GROUP BY city
ORDER BY average_score DESC;


-- ------------------------------------------------------------
-- 18. WHERE + GROUP BY
-- Analyze only students scoring above 75
-- ------------------------------------------------------------

SELECT
    department,
    COUNT(*) AS qualifying_students,
    ROUND(AVG(score), 2) AS average_score
FROM student_scores
WHERE score > 75
GROUP BY department;


-- ------------------------------------------------------------
-- 19. GROUP BY + HAVING + ORDER BY
-- ------------------------------------------------------------

SELECT
    department,
    ROUND(AVG(score), 2) AS average_score
FROM student_scores
GROUP BY department
HAVING AVG(score) >= 80
ORDER BY average_score DESC;


-- ------------------------------------------------------------
-- 20. Complete analytical query
-- WHERE + GROUP BY + HAVING + ORDER BY
-- ------------------------------------------------------------

SELECT
    department,
    COUNT(*) AS students_scoring_75_plus,
    ROUND(AVG(score), 2) AS average_score
FROM student_scores
WHERE score >= 75
GROUP BY department
HAVING COUNT(*) >= 2
ORDER BY average_score DESC;