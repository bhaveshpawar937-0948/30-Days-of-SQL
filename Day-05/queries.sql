-- ============================================================
-- 30 Days of SQL
-- Day 05: Aggregate Functions
-- Author: Bhavesh Pawar
-- ============================================================

USE sql_30_days;

-- ------------------------------------------------------------
-- Setup table for today's practice
-- ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS student_scores (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    department VARCHAR(100),
    city VARCHAR(100),
    score INT
);


-- ------------------------------------------------------------
-- Insert sample data
-- Run once if the table is empty
-- ------------------------------------------------------------

INSERT INTO student_scores
    (student_id, student_name, department, city, score)
VALUES
    (1, 'Rahul', 'Computer Science', 'Mumbai', 78),
    (2, 'Priya', 'Artificial Intelligence', 'Pune', 92),
    (3, 'Aman', 'Data Science', 'Mumbai', 85),
    (4, 'Sneha', 'Artificial Intelligence', 'Navi Mumbai', 88),
    (5, 'Rohan', 'Computer Science', 'Pune', 69),
    (6, 'Neha', 'Data Science', 'Navi Mumbai', 95),
    (7, 'Arjun', 'Computer Science', 'Mumbai', 74),
    (8, 'Kavya', 'Artificial Intelligence', 'Pune', 91),
    (9, 'Vikram', 'Data Science', 'Mumbai', 81),
    (10, 'Isha', 'Computer Science', 'Navi Mumbai', 87);


-- ------------------------------------------------------------
-- 1. Display all records
-- ------------------------------------------------------------

SELECT *
FROM student_scores;


-- ------------------------------------------------------------
-- 2. Count total number of students
-- ------------------------------------------------------------

SELECT COUNT(*) AS total_students
FROM student_scores;


-- ------------------------------------------------------------
-- 3. Count non-null score values
-- ------------------------------------------------------------

SELECT COUNT(score) AS students_with_scores
FROM student_scores;


-- ------------------------------------------------------------
-- 4. Count unique departments
-- ------------------------------------------------------------

SELECT COUNT(DISTINCT department) AS total_departments
FROM student_scores;


-- ------------------------------------------------------------
-- 5. Count unique cities
-- ------------------------------------------------------------

SELECT COUNT(DISTINCT city) AS total_cities
FROM student_scores;


-- ------------------------------------------------------------
-- 6. Calculate total score
-- ------------------------------------------------------------

SELECT SUM(score) AS total_score
FROM student_scores;


-- ------------------------------------------------------------
-- 7. Calculate average score
-- ------------------------------------------------------------

SELECT AVG(score) AS average_score
FROM student_scores;


-- ------------------------------------------------------------
-- 8. Find lowest score
-- ------------------------------------------------------------

SELECT MIN(score) AS lowest_score
FROM student_scores;


-- ------------------------------------------------------------
-- 9. Find highest score
-- ------------------------------------------------------------

SELECT MAX(score) AS highest_score
FROM student_scores;


-- ------------------------------------------------------------
-- 10. Display complete score summary
-- ------------------------------------------------------------

SELECT
    COUNT(*) AS total_students,
    SUM(score) AS total_score,
    AVG(score) AS average_score,
    MIN(score) AS lowest_score,
    MAX(score) AS highest_score
FROM student_scores;


-- ------------------------------------------------------------
-- 11. Count students scoring above 80
-- ------------------------------------------------------------

SELECT COUNT(*) AS students_above_80
FROM student_scores
WHERE score > 80;


-- ------------------------------------------------------------
-- 12. Count students scoring 90 or higher
-- ------------------------------------------------------------

SELECT COUNT(*) AS students_scoring_90_plus
FROM student_scores
WHERE score >= 90;


-- ------------------------------------------------------------
-- 13. Calculate average score for Data Science students
-- ------------------------------------------------------------

SELECT AVG(score) AS data_science_average
FROM student_scores
WHERE department = 'Data Science';


-- ------------------------------------------------------------
-- 14. Calculate average score for AI students
-- ------------------------------------------------------------

SELECT AVG(score) AS ai_average
FROM student_scores
WHERE department = 'Artificial Intelligence';


-- ------------------------------------------------------------
-- 15. Find highest score among Computer Science students
-- ------------------------------------------------------------

SELECT MAX(score) AS cs_highest_score
FROM student_scores
WHERE department = 'Computer Science';


-- ------------------------------------------------------------
-- 16. Find lowest Data Science score
-- ------------------------------------------------------------

SELECT MIN(score) AS data_science_lowest_score
FROM student_scores
WHERE department = 'Data Science';


-- ------------------------------------------------------------
-- 17. Count students from Mumbai
-- ------------------------------------------------------------

SELECT COUNT(*) AS mumbai_students
FROM student_scores
WHERE city = 'Mumbai';


-- ------------------------------------------------------------
-- 18. Calculate average score of Mumbai students
-- ------------------------------------------------------------

SELECT AVG(score) AS mumbai_average_score
FROM student_scores
WHERE city = 'Mumbai';


-- ------------------------------------------------------------
-- 19. Find highest score among Pune students
-- ------------------------------------------------------------

SELECT MAX(score) AS pune_highest_score
FROM student_scores
WHERE city = 'Pune';


-- ------------------------------------------------------------
-- 20. Find lowest score among Navi Mumbai students
-- ------------------------------------------------------------

SELECT MIN(score) AS navi_mumbai_lowest_score
FROM student_scores
WHERE city = 'Navi Mumbai';


-- ------------------------------------------------------------
-- 21. Calculate total score of students scoring above 80
-- ------------------------------------------------------------

SELECT SUM(score) AS total_score_above_80
FROM student_scores
WHERE score > 80;


-- ------------------------------------------------------------
-- 22. Calculate average score for students scoring above 75
-- ------------------------------------------------------------

SELECT AVG(score) AS average_score_above_75
FROM student_scores
WHERE score > 75;


-- ------------------------------------------------------------
-- 23. Count students whose score is between 70 and 90
-- ------------------------------------------------------------

SELECT COUNT(*) AS students_between_70_and_90
FROM student_scores
WHERE score BETWEEN 70 AND 90;


-- ------------------------------------------------------------
-- 24. Average score of students from Mumbai or Pune
-- ------------------------------------------------------------

SELECT AVG(score) AS average_mumbai_pune
FROM student_scores
WHERE city IN ('Mumbai', 'Pune');


-- ------------------------------------------------------------
-- 25. Count high-performing students
-- ------------------------------------------------------------

SELECT COUNT(*) AS high_performers
FROM student_scores
WHERE score >= 85;


-- ------------------------------------------------------------
-- 26. Highest score below 90
-- ------------------------------------------------------------

SELECT MAX(score) AS highest_score_below_90
FROM student_scores
WHERE score < 90;


-- ------------------------------------------------------------
-- 27. Lowest score above 75
-- ------------------------------------------------------------

SELECT MIN(score) AS lowest_score_above_75
FROM student_scores
WHERE score > 75;


-- ------------------------------------------------------------
-- 28. Calculate range between highest and lowest score
-- ------------------------------------------------------------

SELECT
    MAX(score) - MIN(score) AS score_range
FROM student_scores;


-- ------------------------------------------------------------
-- 29. Calculate approximate average rounded to 2 decimals
-- ------------------------------------------------------------

SELECT
    ROUND(AVG(score), 2) AS average_score
FROM student_scores;


-- ------------------------------------------------------------
-- 30. Create a compact performance summary
-- ------------------------------------------------------------

SELECT
    COUNT(*) AS total_students,
    COUNT(DISTINCT department) AS departments,
    ROUND(AVG(score), 2) AS average_score,
    MIN(score) AS lowest_score,
    MAX(score) AS highest_score,
    MAX(score) - MIN(score) AS score_range
FROM student_scores;
