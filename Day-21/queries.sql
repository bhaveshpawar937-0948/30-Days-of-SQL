-- ============================================================
-- 30 Days of SQL
-- Day 21: LAG, LEAD, FIRST_VALUE & LAST_VALUE
-- Author: Bhavesh Pawar
-- ============================================================

USE sql_30_days;


-- ------------------------------------------------------------
-- 1. Previous employee salary
-- ------------------------------------------------------------

SELECT
    employee_id,
    employee_name,
    salary,

    LAG(salary) OVER (
        ORDER BY employee_id
    ) AS previous_salary

FROM employees;


-- ------------------------------------------------------------
-- 2. Next employee salary
-- ------------------------------------------------------------

SELECT
    employee_id,
    employee_name,
    salary,

    LEAD(salary) OVER (
        ORDER BY employee_id
    ) AS next_salary

FROM employees;


-- ------------------------------------------------------------
-- 3. Previous and next salary together
-- ------------------------------------------------------------

SELECT
    employee_name,
    salary,

    LAG(salary) OVER (
        ORDER BY employee_id
    ) AS previous_salary,

    LEAD(salary) OVER (
        ORDER BY employee_id
    ) AS next_salary

FROM employees;


-- ------------------------------------------------------------
-- 4. Difference from previous salary
-- ------------------------------------------------------------

SELECT
    employee_name,
    salary,

    salary -
    LAG(salary) OVER (
        ORDER BY employee_id
    ) AS difference_from_previous

FROM employees;


-- ------------------------------------------------------------
-- 5. Difference from next salary
-- ------------------------------------------------------------

SELECT
    employee_name,
    salary,

    LEAD(salary) OVER (
        ORDER BY employee_id
    ) - salary AS difference_to_next

FROM employees;


-- ------------------------------------------------------------
-- 6. Two rows backward
-- ------------------------------------------------------------

SELECT
    employee_name,
    salary,

    LAG(salary, 2) OVER (
        ORDER BY employee_id
    ) AS salary_two_rows_back

FROM employees;


-- ------------------------------------------------------------
-- 7. Two rows forward
-- ------------------------------------------------------------

SELECT
    employee_name,
    salary,

    LEAD(salary, 2) OVER (
        ORDER BY employee_id
    ) AS salary_two_rows_forward

FROM employees;


-- ------------------------------------------------------------
-- 8. LAG with default value
-- ------------------------------------------------------------

SELECT
    employee_name,
    salary,

    LAG(salary, 1, 0) OVER (
        ORDER BY employee_id
    ) AS previous_salary

FROM employees;


-- ------------------------------------------------------------
-- 9. LEAD with default value
-- ------------------------------------------------------------

SELECT
    employee_name,
    salary,

    LEAD(salary, 1, 0) OVER (
        ORDER BY employee_id
    ) AS next_salary

FROM employees;


-- ------------------------------------------------------------
-- 10. Previous salary within department
-- ------------------------------------------------------------

SELECT
    employee_name,
    department,
    salary,

    LAG(salary) OVER (
        PARTITION BY department
        ORDER BY salary
    ) AS previous_department_salary

FROM employees;


-- ------------------------------------------------------------
-- 11. Next salary within department
-- ------------------------------------------------------------

SELECT
    employee_name,
    department,
    salary,

    LEAD(salary) OVER (
        PARTITION BY department
        ORDER BY salary
    ) AS next_department_salary

FROM employees;


-- ------------------------------------------------------------
-- 12. Salary increase within department
-- ------------------------------------------------------------

SELECT
    employee_name,
    department,
    salary,

    salary -
    LAG(salary) OVER (
        PARTITION BY department
        ORDER BY salary
    ) AS salary_gap

FROM employees;


-- ------------------------------------------------------------
-- 13. Previous employee alphabetically
-- ------------------------------------------------------------

SELECT
    employee_name,

    LAG(employee_name) OVER (
        ORDER BY employee_name
    ) AS previous_employee

FROM employees;


-- ------------------------------------------------------------
-- 14. Next employee alphabetically
-- ------------------------------------------------------------

SELECT
    employee_name,

    LEAD(employee_name) OVER (
        ORDER BY employee_name
    ) AS next_employee

FROM employees;


-- ------------------------------------------------------------
-- 15. Previous student score
-- ------------------------------------------------------------

SELECT
    student_id,
    student_name,
    score,

    LAG(score) OVER (
        ORDER BY student_id
    ) AS previous_score

FROM student_scores;


-- ------------------------------------------------------------
-- 16. Next student score
-- ------------------------------------------------------------

SELECT
    student_id,
    student_name,
    score,

    LEAD(score) OVER (
        ORDER BY student_id
    ) AS next_score

FROM student_scores;


-- ------------------------------------------------------------
-- 17. Student score change
-- ------------------------------------------------------------

SELECT
    student_name,
    score,

    score -
    LAG(score) OVER (
        ORDER BY student_id
    ) AS score_change

FROM student_scores;


-- ------------------------------------------------------------
-- 18. Previous score within department
-- ------------------------------------------------------------

SELECT
    student_name,
    department,
    score,

    LAG(score) OVER (
        PARTITION BY department
        ORDER BY score
    ) AS previous_department_score

FROM student_scores;


-- ------------------------------------------------------------
-- 19. Next score within department
-- ------------------------------------------------------------

SELECT
    student_name,
    department,
    score,

    LEAD(score) OVER (
        PARTITION BY department
        ORDER BY score
    ) AS next_department_score

FROM student_scores;


-- ------------------------------------------------------------
-- 20. Highest salary in each department
-- using FIRST_VALUE
-- ------------------------------------------------------------

SELECT
    employee_name,
    department,
    salary,

    FIRST_VALUE(salary) OVER (
        PARTITION BY department
        ORDER BY salary DESC
    ) AS highest_department_salary

FROM employees;


-- ------------------------------------------------------------
-- 21. Highest-paid employee name in department
-- ------------------------------------------------------------

SELECT
    employee_name,
    department,
    salary,

    FIRST_VALUE(employee_name) OVER (
        PARTITION BY department
        ORDER BY salary DESC, employee_id
    ) AS highest_paid_employee

FROM employees;


-- ------------------------------------------------------------
-- 22. Lowest salary using FIRST_VALUE
-- ------------------------------------------------------------

SELECT
    employee_name,
    department,
    salary,

    FIRST_VALUE(salary) OVER (
        PARTITION BY department
        ORDER BY salary ASC
    ) AS lowest_department_salary

FROM employees;


-- ------------------------------------------------------------
-- 23. Lowest salary using LAST_VALUE
-- ------------------------------------------------------------

SELECT
    employee_name,
    department,
    salary,

    LAST_VALUE(salary) OVER (
        PARTITION BY department
        ORDER BY salary DESC
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND UNBOUNDED FOLLOWING
    ) AS lowest_department_salary

FROM employees;


-- ------------------------------------------------------------
-- 24. Highest and lowest department salary
-- ------------------------------------------------------------

SELECT
    employee_name,
    department,
    salary,

    FIRST_VALUE(salary) OVER (
        PARTITION BY department
        ORDER BY salary DESC
    ) AS highest_salary,

    LAST_VALUE(salary) OVER (
        PARTITION BY department
        ORDER BY salary DESC
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND UNBOUNDED FOLLOWING
    ) AS lowest_salary

FROM employees;


-- ------------------------------------------------------------
-- 25. Difference from highest department salary
-- ------------------------------------------------------------

SELECT
    employee_name,
    department,
    salary,

    FIRST_VALUE(salary) OVER (
        PARTITION BY department
        ORDER BY salary DESC
    ) - salary AS difference_from_highest

FROM employees;


-- ------------------------------------------------------------
-- 26. Highest student score in each department
-- ------------------------------------------------------------

SELECT
    student_name,
    department,
    score,

    FIRST_VALUE(score) OVER (
        PARTITION BY department
        ORDER BY score DESC
    ) AS highest_department_score

FROM student_scores;


-- ------------------------------------------------------------
-- 27. Lowest student score in each department
-- ------------------------------------------------------------

SELECT
    student_name,
    department,
    score,

    LAST_VALUE(score) OVER (
        PARTITION BY department
        ORDER BY score DESC
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND UNBOUNDED FOLLOWING
    ) AS lowest_department_score

FROM student_scores;


-- ------------------------------------------------------------
-- 28. CTE salary change analysis
-- ------------------------------------------------------------

WITH salary_changes AS (
    SELECT
        employee_id,
        employee_name,
        department,
        salary,

        LAG(salary) OVER (
            ORDER BY employee_id
        ) AS previous_salary

    FROM employees
)

SELECT
    employee_id,
    employee_name,
    department,
    salary,
    previous_salary,

    salary - previous_salary
        AS salary_difference

FROM salary_changes;


-- ------------------------------------------------------------
-- 29. Classify change from previous employee
-- ------------------------------------------------------------

WITH salary_changes AS (
    SELECT
        employee_name,
        salary,

        LAG(salary) OVER (
            ORDER BY employee_id
        ) AS previous_salary

    FROM employees
)

SELECT
    employee_name,
    salary,
    previous_salary,

    CASE
        WHEN previous_salary IS NULL
            THEN 'First Record'

        WHEN salary > previous_salary
            THEN 'Increase'

        WHEN salary < previous_salary
            THEN 'Decrease'

        ELSE 'No Change'
    END AS change_status

FROM salary_changes;


-- ------------------------------------------------------------
-- 30. Final navigation window analytics report
-- ------------------------------------------------------------

SELECT
    employee_id,
    employee_name,
    department,
    salary,

    LAG(salary) OVER (
        PARTITION BY department
        ORDER BY salary
    ) AS previous_salary,

    LEAD(salary) OVER (
        PARTITION BY department
        ORDER BY salary
    ) AS next_salary,

    FIRST_VALUE(salary) OVER (
        PARTITION BY department
        ORDER BY salary DESC
    ) AS highest_department_salary,

    LAST_VALUE(salary) OVER (
        PARTITION BY department
        ORDER BY salary DESC
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND UNBOUNDED FOLLOWING
    ) AS lowest_department_salary,

    salary -
    LAG(salary) OVER (
        PARTITION BY department
        ORDER BY salary
    ) AS difference_from_previous

FROM employees

ORDER BY department, salary;