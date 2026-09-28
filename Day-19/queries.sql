-- ============================================================
-- 30 Days of SQL
-- Day 19: Window Functions
-- ROW_NUMBER, RANK & DENSE_RANK
-- Author: Bhavesh Pawar
-- ============================================================

USE sql_30_days;


-- ------------------------------------------------------------
-- 1. Assign sequential numbers to employees
-- ------------------------------------------------------------

SELECT
    employee_id,
    employee_name,

    ROW_NUMBER() OVER (
        ORDER BY employee_id
    ) AS row_number

FROM employees;


-- ------------------------------------------------------------
-- 2. Number employees by salary
-- ------------------------------------------------------------

SELECT
    employee_name,
    salary,

    ROW_NUMBER() OVER (
        ORDER BY salary DESC
    ) AS salary_position

FROM employees;


-- ------------------------------------------------------------
-- 3. Rank employees by salary
-- ------------------------------------------------------------

SELECT
    employee_name,
    salary,

    RANK() OVER (
        ORDER BY salary DESC
    ) AS salary_rank

FROM employees;


-- ------------------------------------------------------------
-- 4. Dense-rank employees by salary
-- ------------------------------------------------------------

SELECT
    employee_name,
    salary,

    DENSE_RANK() OVER (
        ORDER BY salary DESC
    ) AS salary_dense_rank

FROM employees;


-- ------------------------------------------------------------
-- 5. Compare all three ranking functions
-- ------------------------------------------------------------

SELECT
    employee_name,
    salary,

    ROW_NUMBER() OVER (
        ORDER BY salary DESC
    ) AS row_number,

    RANK() OVER (
        ORDER BY salary DESC
    ) AS salary_rank,

    DENSE_RANK() OVER (
        ORDER BY salary DESC
    ) AS dense_rank

FROM employees;


-- ------------------------------------------------------------
-- 6. Rank employees within departments
-- ------------------------------------------------------------

SELECT
    employee_name,
    department,
    salary,

    RANK() OVER (
        PARTITION BY department
        ORDER BY salary DESC
    ) AS department_rank

FROM employees;


-- ------------------------------------------------------------
-- 7. Dense-rank employees within departments
-- ------------------------------------------------------------

SELECT
    employee_name,
    department,
    salary,

    DENSE_RANK() OVER (
        PARTITION BY department
        ORDER BY salary DESC
    ) AS department_rank

FROM employees;


-- ------------------------------------------------------------
-- 8. Assign department-specific row numbers
-- ------------------------------------------------------------

SELECT
    employee_name,
    department,
    salary,

    ROW_NUMBER() OVER (
        PARTITION BY department
        ORDER BY salary DESC
    ) AS department_position

FROM employees;


-- ------------------------------------------------------------
-- 9. Rank employees from lowest salary upward
-- ------------------------------------------------------------

SELECT
    employee_name,
    department,
    salary,

    RANK() OVER (
        ORDER BY salary ASC
    ) AS lowest_salary_rank

FROM employees;


-- ------------------------------------------------------------
-- 10. Overall student ranking
-- ------------------------------------------------------------

SELECT
    student_name,
    department,
    score,

    RANK() OVER (
        ORDER BY score DESC
    ) AS overall_rank

FROM student_scores;


-- ------------------------------------------------------------
-- 11. Student dense ranking
-- ------------------------------------------------------------

SELECT
    student_name,
    department,
    score,

    DENSE_RANK() OVER (
        ORDER BY score DESC
    ) AS overall_rank

FROM student_scores;


-- ------------------------------------------------------------
-- 12. Student ranking within departments
-- ------------------------------------------------------------

SELECT
    student_name,
    department,
    score,

    RANK() OVER (
        PARTITION BY department
        ORDER BY score DESC
    ) AS department_rank

FROM student_scores;


-- ------------------------------------------------------------
-- 13. Compare student ranking functions
-- ------------------------------------------------------------

SELECT
    student_name,
    score,

    ROW_NUMBER() OVER (
        ORDER BY score DESC
    ) AS row_number,

    RANK() OVER (
        ORDER BY score DESC
    ) AS score_rank,

    DENSE_RANK() OVER (
        ORDER BY score DESC
    ) AS dense_rank

FROM student_scores;


-- ------------------------------------------------------------
-- 14. Top 5 highest-paid employees
-- ------------------------------------------------------------

WITH ranked_employees AS (
    SELECT
        employee_name,
        department,
        salary,

        ROW_NUMBER() OVER (
            ORDER BY salary DESC
        ) AS salary_position

    FROM employees
)

SELECT *
FROM ranked_employees
WHERE salary_position <= 5;


-- ------------------------------------------------------------
-- 15. Top 3 employees from each department
-- ------------------------------------------------------------

WITH ranked_employees AS (
    SELECT
        employee_name,
        department,
        salary,

        ROW_NUMBER() OVER (
            PARTITION BY department
            ORDER BY salary DESC
        ) AS salary_position

    FROM employees
)

SELECT *
FROM ranked_employees
WHERE salary_position <= 3
ORDER BY department, salary_position;


-- ------------------------------------------------------------
-- 16. Highest-paid employee per department
-- ------------------------------------------------------------

WITH ranked_employees AS (
    SELECT
        employee_name,
        department,
        salary,

        ROW_NUMBER() OVER (
            PARTITION BY department
            ORDER BY salary DESC
        ) AS salary_position

    FROM employees
)

SELECT
    employee_name,
    department,
    salary

FROM ranked_employees

WHERE salary_position = 1;


-- ------------------------------------------------------------
-- 17. Second-highest salary in each department
-- ------------------------------------------------------------

WITH ranked_employees AS (
    SELECT
        employee_name,
        department,
        salary,

        DENSE_RANK() OVER (
            PARTITION BY department
            ORDER BY salary DESC
        ) AS salary_rank

    FROM employees
)

SELECT *
FROM ranked_employees
WHERE salary_rank = 2;


-- ------------------------------------------------------------
-- 18. Lowest-paid employee per department
-- ------------------------------------------------------------

WITH ranked_employees AS (
    SELECT
        employee_name,
        department,
        salary,

        ROW_NUMBER() OVER (
            PARTITION BY department
            ORDER BY salary ASC
        ) AS salary_position

    FROM employees
)

SELECT
    employee_name,
    department,
    salary

FROM ranked_employees
WHERE salary_position = 1;


-- ------------------------------------------------------------
-- 19. Top 3 students overall
-- ------------------------------------------------------------

WITH ranked_students AS (
    SELECT
        student_name,
        department,
        score,

        DENSE_RANK() OVER (
            ORDER BY score DESC
        ) AS score_rank

    FROM student_scores
)

SELECT *
FROM ranked_students
WHERE score_rank <= 3;


-- ------------------------------------------------------------
-- 20. Top 2 students per department
-- ------------------------------------------------------------

WITH ranked_students AS (
    SELECT
        student_name,
        department,
        score,

        ROW_NUMBER() OVER (
            PARTITION BY department
            ORDER BY score DESC
        ) AS department_position

    FROM student_scores
)

SELECT *
FROM ranked_students
WHERE department_position <= 2
ORDER BY department, department_position;


-- ------------------------------------------------------------
-- 21. Highest-scoring student per department
-- ------------------------------------------------------------

WITH ranked_students AS (
    SELECT
        student_name,
        department,
        score,

        RANK() OVER (
            PARTITION BY department
            ORDER BY score DESC
        ) AS score_rank

    FROM student_scores
)

SELECT *
FROM ranked_students
WHERE score_rank = 1;


-- ------------------------------------------------------------
-- 22. Find employees ranked 3rd to 5th
-- ------------------------------------------------------------

WITH ranked_employees AS (
    SELECT
        employee_name,
        department,
        salary,

        ROW_NUMBER() OVER (
            ORDER BY salary DESC
        ) AS salary_position

    FROM employees
)

SELECT *
FROM ranked_employees
WHERE salary_position BETWEEN 3 AND 5;


-- ------------------------------------------------------------
-- 23. Rank only higher-salary employees
-- ------------------------------------------------------------

WITH filtered_employees AS (
    SELECT
        employee_name,
        department,
        salary
    FROM employees
    WHERE salary >= 60000
),

ranked_employees AS (
    SELECT
        employee_name,
        department,
        salary,

        RANK() OVER (
            ORDER BY salary DESC
        ) AS salary_rank

    FROM filtered_employees
)

SELECT *
FROM ranked_employees;


-- ------------------------------------------------------------
-- 24. Rank departments by average salary
-- ------------------------------------------------------------

WITH department_stats AS (
    SELECT
        department,
        ROUND(AVG(salary), 2)
            AS average_salary
    FROM employees
    GROUP BY department
)

SELECT
    department,
    average_salary,

    RANK() OVER (
        ORDER BY average_salary DESC
    ) AS department_rank

FROM department_stats;


-- ------------------------------------------------------------
-- 25. Rank departments by employee count
-- ------------------------------------------------------------

WITH department_counts AS (
    SELECT
        department,
        COUNT(*) AS employee_count
    FROM employees
    GROUP BY department
)

SELECT
    department,
    employee_count,

    DENSE_RANK() OVER (
        ORDER BY employee_count DESC
    ) AS size_rank

FROM department_counts;


-- ------------------------------------------------------------
-- 26. Rank departments by average student score
-- ------------------------------------------------------------

WITH department_scores AS (
    SELECT
        department,
        ROUND(AVG(score), 2)
            AS average_score
    FROM student_scores
    GROUP BY department
)

SELECT
    department,
    average_score,

    RANK() OVER (
        ORDER BY average_score DESC
    ) AS performance_rank

FROM department_scores;


-- ------------------------------------------------------------
-- 27. Rank employees alphabetically within departments
-- ------------------------------------------------------------

SELECT
    employee_name,
    department,

    ROW_NUMBER() OVER (
        PARTITION BY department
        ORDER BY employee_name
    ) AS alphabetical_position

FROM employees;


-- ------------------------------------------------------------
-- 28. Create salary leaderboard
-- ------------------------------------------------------------

SELECT
    employee_name,
    department,
    salary,

    DENSE_RANK() OVER (
        ORDER BY salary DESC
    ) AS overall_salary_rank,

    DENSE_RANK() OVER (
        PARTITION BY department
        ORDER BY salary DESC
    ) AS department_salary_rank

FROM employees

ORDER BY overall_salary_rank;


-- ------------------------------------------------------------
-- 29. Create student leaderboard
-- ------------------------------------------------------------

SELECT
    student_name,
    department,
    score,

    DENSE_RANK() OVER (
        ORDER BY score DESC
    ) AS overall_rank,

    DENSE_RANK() OVER (
        PARTITION BY department
        ORDER BY score DESC
    ) AS department_rank

FROM student_scores

ORDER BY overall_rank;


-- ------------------------------------------------------------
-- 30. Final employee ranking report
-- ------------------------------------------------------------

WITH employee_rankings AS (
    SELECT
        employee_id,
        employee_name,
        department,
        job_role,
        salary,

        ROW_NUMBER() OVER (
            ORDER BY salary DESC
        ) AS salary_position,

        DENSE_RANK() OVER (
            ORDER BY salary DESC
        ) AS overall_salary_rank,

        DENSE_RANK() OVER (
            PARTITION BY department
            ORDER BY salary DESC
        ) AS department_salary_rank

    FROM employees
)

SELECT
    employee_id,
    employee_name,
    department,
    job_role,
    salary,
    salary_position,
    overall_salary_rank,
    department_salary_rank

FROM employee_rankings

ORDER BY salary_position;
