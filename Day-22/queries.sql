-- ============================================================
-- 30 Days of SQL
-- Day 22: NTILE, PERCENT_RANK & CUME_DIST
-- Author: Bhavesh Pawar
-- ============================================================

USE sql_30_days;


-- ------------------------------------------------------------
-- 1. Divide employees into salary quartiles
-- ------------------------------------------------------------

SELECT
    employee_name,
    salary,

    NTILE(4) OVER (
        ORDER BY salary
    ) AS salary_quartile

FROM employees;


-- ------------------------------------------------------------
-- 2. Highest salaries in Quartile 1
-- ------------------------------------------------------------

SELECT
    employee_name,
    salary,

    NTILE(4) OVER (
        ORDER BY salary DESC
    ) AS salary_quartile

FROM employees;


-- ------------------------------------------------------------
-- 3. Divide salaries into three groups
-- ------------------------------------------------------------

SELECT
    employee_name,
    salary,

    NTILE(3) OVER (
        ORDER BY salary
    ) AS salary_group

FROM employees;


-- ------------------------------------------------------------
-- 4. Divide salaries into five groups
-- ------------------------------------------------------------

SELECT
    employee_name,
    salary,

    NTILE(5) OVER (
        ORDER BY salary
    ) AS salary_group

FROM employees;


-- ------------------------------------------------------------
-- 5. Salary deciles
-- ------------------------------------------------------------

SELECT
    employee_name,
    salary,

    NTILE(10) OVER (
        ORDER BY salary
    ) AS salary_decile

FROM employees;


-- ------------------------------------------------------------
-- 6. Salary quartiles inside departments
-- ------------------------------------------------------------

SELECT
    employee_name,
    department,
    salary,

    NTILE(4) OVER (
        PARTITION BY department
        ORDER BY salary
    ) AS department_salary_quartile

FROM employees;


-- ------------------------------------------------------------
-- 7. Student performance quartiles
-- ------------------------------------------------------------

SELECT
    student_name,
    score,

    NTILE(4) OVER (
        ORDER BY score DESC
    ) AS performance_quartile

FROM student_scores;


-- ------------------------------------------------------------
-- 8. Student quartiles within departments
-- ------------------------------------------------------------

SELECT
    student_name,
    department,
    score,

    NTILE(4) OVER (
        PARTITION BY department
        ORDER BY score DESC
    ) AS department_quartile

FROM student_scores;


-- ------------------------------------------------------------
-- 9. Employee salary percent rank
-- ------------------------------------------------------------

SELECT
    employee_name,
    salary,

    PERCENT_RANK() OVER (
        ORDER BY salary
    ) AS salary_percent_rank

FROM employees;


-- ------------------------------------------------------------
-- 10. Convert percent rank to percentage
-- ------------------------------------------------------------

SELECT
    employee_name,
    salary,

    ROUND(
        PERCENT_RANK() OVER (
            ORDER BY salary
        ) * 100,
        2
    ) AS salary_percent_rank

FROM employees;


-- ------------------------------------------------------------
-- 11. Percent rank from highest salary downward
-- ------------------------------------------------------------

SELECT
    employee_name,
    salary,

    ROUND(
        PERCENT_RANK() OVER (
            ORDER BY salary DESC
        ) * 100,
        2
    ) AS salary_percent_rank

FROM employees;


-- ------------------------------------------------------------
-- 12. Percent rank inside each department
-- ------------------------------------------------------------

SELECT
    employee_name,
    department,
    salary,

    ROUND(
        PERCENT_RANK() OVER (
            PARTITION BY department
            ORDER BY salary
        ) * 100,
        2
    ) AS department_percent_rank

FROM employees;


-- ------------------------------------------------------------
-- 13. Student score percent rank
-- ------------------------------------------------------------

SELECT
    student_name,
    score,

    ROUND(
        PERCENT_RANK() OVER (
            ORDER BY score
        ) * 100,
        2
    ) AS score_percent_rank

FROM student_scores;


-- ------------------------------------------------------------
-- 14. Student percent rank inside department
-- ------------------------------------------------------------

SELECT
    student_name,
    department,
    score,

    ROUND(
        PERCENT_RANK() OVER (
            PARTITION BY department
            ORDER BY score
        ) * 100,
        2
    ) AS department_percent_rank

FROM student_scores;


-- ------------------------------------------------------------
-- 15. Employee salary cumulative distribution
-- ------------------------------------------------------------

SELECT
    employee_name,
    salary,

    CUME_DIST() OVER (
        ORDER BY salary
    ) AS salary_cumulative_distribution

FROM employees;


-- ------------------------------------------------------------
-- 16. Convert cumulative distribution to percentage
-- ------------------------------------------------------------

SELECT
    employee_name,
    salary,

    ROUND(
        CUME_DIST() OVER (
            ORDER BY salary
        ) * 100,
        2
    ) AS cumulative_percentage

FROM employees;


-- ------------------------------------------------------------
-- 17. Cumulative distribution inside departments
-- ------------------------------------------------------------

SELECT
    employee_name,
    department,
    salary,

    ROUND(
        CUME_DIST() OVER (
            PARTITION BY department
            ORDER BY salary
        ) * 100,
        2
    ) AS department_cumulative_percentage

FROM employees;


-- ------------------------------------------------------------
-- 18. Student cumulative distribution
-- ------------------------------------------------------------

SELECT
    student_name,
    score,

    ROUND(
        CUME_DIST() OVER (
            ORDER BY score
        ) * 100,
        2
    ) AS score_cumulative_percentage

FROM student_scores;


-- ------------------------------------------------------------
-- 19. Compare PERCENT_RANK and CUME_DIST
-- ------------------------------------------------------------

SELECT
    employee_name,
    salary,

    ROUND(
        PERCENT_RANK() OVER (
            ORDER BY salary
        ) * 100,
        2
    ) AS percent_rank,

    ROUND(
        CUME_DIST() OVER (
            ORDER BY salary
        ) * 100,
        2
    ) AS cumulative_distribution

FROM employees;


-- ------------------------------------------------------------
-- 20. Compare ranking and distribution
-- ------------------------------------------------------------

SELECT
    employee_name,
    salary,

    RANK() OVER (
        ORDER BY salary
    ) AS salary_rank,

    NTILE(4) OVER (
        ORDER BY salary
    ) AS salary_quartile,

    ROUND(
        PERCENT_RANK() OVER (
            ORDER BY salary
        ) * 100,
        2
    ) AS percent_rank,

    ROUND(
        CUME_DIST() OVER (
            ORDER BY salary
        ) * 100,
        2
    ) AS cumulative_percentage

FROM employees;


-- ------------------------------------------------------------
-- 21. Label salary quartiles
-- ------------------------------------------------------------

WITH salary_segments AS (
    SELECT
        employee_name,
        department,
        salary,

        NTILE(4) OVER (
            ORDER BY salary
        ) AS salary_quartile

    FROM employees
)

SELECT
    employee_name,
    department,
    salary,
    salary_quartile,

    CASE
        WHEN salary_quartile = 4
            THEN 'High Salary'

        WHEN salary_quartile = 3
            THEN 'Upper Medium'

        WHEN salary_quartile = 2
            THEN 'Lower Medium'

        ELSE 'Low Salary'
    END AS salary_segment

FROM salary_segments

ORDER BY salary;


-- ------------------------------------------------------------
-- 22. Label student performance quartiles
-- ------------------------------------------------------------

WITH student_segments AS (
    SELECT
        student_name,
        department,
        score,

        NTILE(4) OVER (
            ORDER BY score DESC
        ) AS performance_quartile

    FROM student_scores
)

SELECT
    student_name,
    department,
    score,
    performance_quartile,

    CASE
        WHEN performance_quartile = 1
            THEN 'Top Performer'

        WHEN performance_quartile = 2
            THEN 'Above Average'

        WHEN performance_quartile = 3
            THEN 'Developing'

        ELSE 'Needs Improvement'
    END AS performance_segment

FROM student_segments

ORDER BY performance_quartile, score DESC;


-- ------------------------------------------------------------
-- 23. Employees in highest salary quartile
-- ------------------------------------------------------------

WITH salary_quartiles AS (
    SELECT
        employee_name,
        department,
        salary,

        NTILE(4) OVER (
            ORDER BY salary
        ) AS salary_quartile

    FROM employees
)

SELECT *
FROM salary_quartiles

WHERE salary_quartile = 4

ORDER BY salary DESC;


-- ------------------------------------------------------------
-- 24. Employees in lowest salary quartile
-- ------------------------------------------------------------

WITH salary_quartiles AS (
    SELECT
        employee_name,
        department,
        salary,

        NTILE(4) OVER (
            ORDER BY salary
        ) AS salary_quartile

    FROM employees
)

SELECT *
FROM salary_quartiles

WHERE salary_quartile = 1

ORDER BY salary;


-- ------------------------------------------------------------
-- 25. Top 20 percent by relative salary position
-- ------------------------------------------------------------

WITH salary_distribution AS (
    SELECT
        employee_name,
        department,
        salary,

        PERCENT_RANK() OVER (
            ORDER BY salary
        ) AS percent_rank

    FROM employees
)

SELECT
    employee_name,
    department,
    salary,

    ROUND(
        percent_rank * 100,
        2
    ) AS percent_rank

FROM salary_distribution

WHERE percent_rank >= 0.80

ORDER BY salary DESC;


-- ------------------------------------------------------------
-- 26. Bottom 20 percent by relative salary position
-- ------------------------------------------------------------

WITH salary_distribution AS (
    SELECT
        employee_name,
        department,
        salary,

        PERCENT_RANK() OVER (
            ORDER BY salary
        ) AS percent_rank

    FROM employees
)

SELECT
    employee_name,
    department,
    salary,

    ROUND(
        percent_rank * 100,
        2
    ) AS percent_rank

FROM salary_distribution

WHERE percent_rank <= 0.20

ORDER BY salary;


-- ------------------------------------------------------------
-- 27. Department-specific salary segments
-- ------------------------------------------------------------

WITH department_segments AS (
    SELECT
        employee_name,
        department,
        salary,

        NTILE(4) OVER (
            PARTITION BY department
            ORDER BY salary
        ) AS salary_quartile

    FROM employees
)

SELECT
    employee_name,
    department,
    salary,
    salary_quartile

FROM department_segments

ORDER BY
    department,
    salary_quartile,
    salary;


-- ------------------------------------------------------------
-- 28. Summarize employees by salary quartile
-- ------------------------------------------------------------

WITH salary_segments AS (
    SELECT
        employee_name,
        salary,

        NTILE(4) OVER (
            ORDER BY salary
        ) AS salary_quartile

    FROM employees
)

SELECT
    salary_quartile,
    COUNT(*) AS employee_count,
    MIN(salary) AS minimum_salary,
    MAX(salary) AS maximum_salary,
    ROUND(
        AVG(salary),
        2
    ) AS average_salary

FROM salary_segments

GROUP BY salary_quartile

ORDER BY salary_quartile;


-- ------------------------------------------------------------
-- 29. Student distribution analytics report
-- ------------------------------------------------------------

SELECT
    student_name,
    department,
    score,

    NTILE(4) OVER (
        ORDER BY score DESC
    ) AS performance_quartile,

    ROUND(
        PERCENT_RANK() OVER (
            ORDER BY score
        ) * 100,
        2
    ) AS score_percent_rank,

    ROUND(
        CUME_DIST() OVER (
            ORDER BY score
        ) * 100,
        2
    ) AS cumulative_score_percentage

FROM student_scores

ORDER BY score DESC;


-- ------------------------------------------------------------
-- 30. Final employee distribution analytics report
-- ------------------------------------------------------------

WITH employee_distribution AS (
    SELECT
        employee_id,
        employee_name,
        department,
        salary,

        NTILE(4) OVER (
            ORDER BY salary
        ) AS company_salary_quartile,

        NTILE(4) OVER (
            PARTITION BY department
            ORDER BY salary
        ) AS department_salary_quartile,

        PERCENT_RANK() OVER (
            ORDER BY salary
        ) AS salary_percent_rank,

        CUME_DIST() OVER (
            ORDER BY salary
        ) AS salary_cumulative_distribution

    FROM employees
)

SELECT
    employee_id,
    employee_name,
    department,
    salary,
    company_salary_quartile,
    department_salary_quartile,

    ROUND(
        salary_percent_rank * 100,
        2
    ) AS salary_percent_rank,

    ROUND(
        salary_cumulative_distribution * 100,
        2
    ) AS cumulative_salary_percentage,

    CASE
        WHEN company_salary_quartile = 4
            THEN 'High Salary'

        WHEN company_salary_quartile = 3
            THEN 'Upper Medium'

        WHEN company_salary_quartile = 2
            THEN 'Lower Medium'

        ELSE 'Low Salary'
    END AS salary_segment

FROM employee_distribution

ORDER BY salary DESC;