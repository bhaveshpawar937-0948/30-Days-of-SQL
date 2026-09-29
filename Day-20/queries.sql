-- ============================================================
-- 30 Days of SQL
-- Day 20: Aggregate Window Functions & Running Totals
-- Author: Bhavesh Pawar
-- ============================================================

USE sql_30_days;


-- ------------------------------------------------------------
-- 1. Display total company payroll on every row
-- ------------------------------------------------------------

SELECT
    employee_name,
    salary,

    SUM(salary) OVER ()
        AS total_company_payroll

FROM employees;


-- ------------------------------------------------------------
-- 2. Display average company salary on every row
-- ------------------------------------------------------------

SELECT
    employee_name,
    salary,

    ROUND(
        AVG(salary) OVER (),
        2
    ) AS company_average_salary

FROM employees;


-- ------------------------------------------------------------
-- 3. Count total employees using a window function
-- ------------------------------------------------------------

SELECT
    employee_name,
    department,

    COUNT(*) OVER ()
        AS total_employees

FROM employees;


-- ------------------------------------------------------------
-- 4. Display company minimum and maximum salaries
-- ------------------------------------------------------------

SELECT
    employee_name,
    salary,

    MIN(salary) OVER ()
        AS company_minimum_salary,

    MAX(salary) OVER ()
        AS company_maximum_salary

FROM employees;


-- ------------------------------------------------------------
-- 5. Department payroll total
-- ------------------------------------------------------------

SELECT
    employee_name,
    department,
    salary,

    SUM(salary) OVER (
        PARTITION BY department
    ) AS department_payroll

FROM employees;


-- ------------------------------------------------------------
-- 6. Department average salary
-- ------------------------------------------------------------

SELECT
    employee_name,
    department,
    salary,

    ROUND(
        AVG(salary) OVER (
            PARTITION BY department
        ),
        2
    ) AS department_average

FROM employees;


-- ------------------------------------------------------------
-- 7. Department employee count
-- ------------------------------------------------------------

SELECT
    employee_name,
    department,

    COUNT(*) OVER (
        PARTITION BY department
    ) AS department_employee_count

FROM employees;


-- ------------------------------------------------------------
-- 8. Department salary range
-- ------------------------------------------------------------

SELECT
    employee_name,
    department,
    salary,

    MIN(salary) OVER (
        PARTITION BY department
    ) AS department_minimum,

    MAX(salary) OVER (
        PARTITION BY department
    ) AS department_maximum

FROM employees;


-- ------------------------------------------------------------
-- 9. Compare employee salary with department average
-- ------------------------------------------------------------

SELECT
    employee_name,
    department,
    salary,

    ROUND(
        AVG(salary) OVER (
            PARTITION BY department
        ),
        2
    ) AS department_average,

    ROUND(
        salary -
        AVG(salary) OVER (
            PARTITION BY department
        ),
        2
    ) AS difference_from_average

FROM employees;


-- ------------------------------------------------------------
-- 10. Overall running salary total by employee ID
-- ------------------------------------------------------------

SELECT
    employee_id,
    employee_name,
    salary,

    SUM(salary) OVER (
        ORDER BY employee_id
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW
    ) AS running_salary_total

FROM employees;


-- ------------------------------------------------------------
-- 11. Running salary total from highest to lowest salary
-- ------------------------------------------------------------

SELECT
    employee_name,
    salary,

    SUM(salary) OVER (
        ORDER BY salary DESC, employee_id
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW
    ) AS cumulative_payroll

FROM employees;


-- ------------------------------------------------------------
-- 12. Department-specific running payroll
-- ------------------------------------------------------------

SELECT
    employee_id,
    employee_name,
    department,
    salary,

    SUM(salary) OVER (
        PARTITION BY department
        ORDER BY employee_id
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW
    ) AS department_running_payroll

FROM employees;


-- ------------------------------------------------------------
-- 13. Running employee count
-- ------------------------------------------------------------

SELECT
    employee_id,
    employee_name,

    COUNT(*) OVER (
        ORDER BY employee_id
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW
    ) AS running_employee_count

FROM employees;


-- ------------------------------------------------------------
-- 14. Cumulative salary average
-- ------------------------------------------------------------

SELECT
    employee_id,
    employee_name,
    salary,

    ROUND(
        AVG(salary) OVER (
            ORDER BY employee_id
            ROWS BETWEEN UNBOUNDED PRECEDING
            AND CURRENT ROW
        ),
        2
    ) AS cumulative_average_salary

FROM employees;


-- ------------------------------------------------------------
-- 15. Student total score across dataset
-- ------------------------------------------------------------

SELECT
    student_name,
    department,
    score,

    SUM(score) OVER ()
        AS total_score

FROM student_scores;


-- ------------------------------------------------------------
-- 16. Department total student score
-- ------------------------------------------------------------

SELECT
    student_name,
    department,
    score,

    SUM(score) OVER (
        PARTITION BY department
    ) AS department_total_score

FROM student_scores;


-- ------------------------------------------------------------
-- 17. Department average student score
-- ------------------------------------------------------------

SELECT
    student_name,
    department,
    score,

    ROUND(
        AVG(score) OVER (
            PARTITION BY department
        ),
        2
    ) AS department_average_score

FROM student_scores;


-- ------------------------------------------------------------
-- 18. Cumulative student score
-- ------------------------------------------------------------

SELECT
    student_id,
    student_name,
    score,

    SUM(score) OVER (
        ORDER BY student_id
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW
    ) AS cumulative_score

FROM student_scores;


-- ------------------------------------------------------------
-- 19. Department cumulative score
-- ------------------------------------------------------------

SELECT
    student_id,
    student_name,
    department,
    score,

    SUM(score) OVER (
        PARTITION BY department
        ORDER BY student_id
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW
    ) AS department_cumulative_score

FROM student_scores;


-- ------------------------------------------------------------
-- 20. Three-row moving average of student scores
-- ------------------------------------------------------------

SELECT
    student_id,
    student_name,
    score,

    ROUND(
        AVG(score) OVER (
            ORDER BY student_id
            ROWS BETWEEN 2 PRECEDING
            AND CURRENT ROW
        ),
        2
    ) AS three_row_moving_average

FROM student_scores;


-- ------------------------------------------------------------
-- 21. Two-row moving salary average
-- ------------------------------------------------------------

SELECT
    employee_id,
    employee_name,
    salary,

    ROUND(
        AVG(salary) OVER (
            ORDER BY employee_id
            ROWS BETWEEN 1 PRECEDING
            AND CURRENT ROW
        ),
        2
    ) AS two_row_moving_average

FROM employees;


-- ------------------------------------------------------------
-- 22. Employee percentage of total company payroll
-- ------------------------------------------------------------

SELECT
    employee_name,
    salary,

    ROUND(
        salary * 100.0 /
        NULLIF(
            SUM(salary) OVER (),
            0
        ),
        2
    ) AS company_payroll_percentage

FROM employees;


-- ------------------------------------------------------------
-- 23. Employee percentage of department payroll
-- ------------------------------------------------------------

SELECT
    employee_name,
    department,
    salary,

    ROUND(
        salary * 100.0 /
        NULLIF(
            SUM(salary) OVER (
                PARTITION BY department
            ),
            0
        ),
        2
    ) AS department_payroll_percentage

FROM employees;


-- ------------------------------------------------------------
-- 24. Student contribution to total score
-- ------------------------------------------------------------

SELECT
    student_name,
    score,

    ROUND(
        score * 100.0 /
        NULLIF(
            SUM(score) OVER (),
            0
        ),
        2
    ) AS total_score_percentage

FROM student_scores;


-- ------------------------------------------------------------
-- 25. Student contribution within department
-- ------------------------------------------------------------

SELECT
    student_name,
    department,
    score,

    ROUND(
        score * 100.0 /
        NULLIF(
            SUM(score) OVER (
                PARTITION BY department
            ),
            0
        ),
        2
    ) AS department_score_percentage

FROM student_scores;


-- ------------------------------------------------------------
-- 26. Salary position inside department range
-- ------------------------------------------------------------

SELECT
    employee_name,
    department,
    salary,

    MIN(salary) OVER (
        PARTITION BY department
    ) AS department_minimum,

    MAX(salary) OVER (
        PARTITION BY department
    ) AS department_maximum,

    salary -
    MIN(salary) OVER (
        PARTITION BY department
    ) AS above_department_minimum

FROM employees;


-- ------------------------------------------------------------
-- 27. Cumulative payroll percentage
-- ------------------------------------------------------------

SELECT
    employee_name,
    salary,

    SUM(salary) OVER (
        ORDER BY salary DESC, employee_id
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW
    ) AS cumulative_salary,

    ROUND(
        SUM(salary) OVER (
            ORDER BY salary DESC, employee_id
            ROWS BETWEEN UNBOUNDED PRECEDING
            AND CURRENT ROW
        )
        * 100.0 /
        NULLIF(
            SUM(salary) OVER (),
            0
        ),
        2
    ) AS cumulative_payroll_percentage

FROM employees;


-- ------------------------------------------------------------
-- 28. Combine ranking with aggregate windows
-- ------------------------------------------------------------

SELECT
    employee_name,
    department,
    salary,

    DENSE_RANK() OVER (
        PARTITION BY department
        ORDER BY salary DESC
    ) AS department_rank,

    ROUND(
        AVG(salary) OVER (
            PARTITION BY department
        ),
        2
    ) AS department_average,

    SUM(salary) OVER (
        PARTITION BY department
    ) AS department_payroll

FROM employees;


-- ------------------------------------------------------------
-- 29. CTE with aggregate window functions
-- ------------------------------------------------------------

WITH employee_analysis AS (
    SELECT
        employee_id,
        employee_name,
        department,
        salary,

        AVG(salary) OVER (
            PARTITION BY department
        ) AS department_average,

        SUM(salary) OVER (
            PARTITION BY department
        ) AS department_total

    FROM employees
)

SELECT
    employee_name,
    department,
    salary,

    ROUND(
        department_average,
        2
    ) AS department_average,

    department_total,

    ROUND(
        salary - department_average,
        2
    ) AS difference_from_average

FROM employee_analysis

ORDER BY department, salary DESC;


-- ------------------------------------------------------------
-- 30. Final employee window analytics report
-- ------------------------------------------------------------

SELECT
    employee_id,
    employee_name,
    department,
    salary,

    COUNT(*) OVER (
        PARTITION BY department
    ) AS department_size,

    ROUND(
        AVG(salary) OVER (
            PARTITION BY department
        ),
        2
    ) AS department_average,

    MIN(salary) OVER (
        PARTITION BY department
    ) AS department_minimum,

    MAX(salary) OVER (
        PARTITION BY department
    ) AS department_maximum,

    SUM(salary) OVER (
        PARTITION BY department
    ) AS department_payroll,

    SUM(salary) OVER (
        PARTITION BY department
        ORDER BY employee_id
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW
    ) AS running_department_payroll,

    ROUND(
        salary * 100.0 /
        NULLIF(
            SUM(salary) OVER (
                PARTITION BY department
            ),
            0
        ),
        2
    ) AS payroll_contribution_percentage

FROM employees

ORDER BY department, employee_id;