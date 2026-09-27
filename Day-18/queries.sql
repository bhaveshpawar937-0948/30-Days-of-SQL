-- ============================================================
-- 30 Days of SQL
-- Day 18: Common Table Expressions (CTEs)
-- Author: Bhavesh Pawar
-- ============================================================

USE sql_30_days;


-- ------------------------------------------------------------
-- 1. Basic CTE
-- ------------------------------------------------------------

WITH employee_data AS (
    SELECT
        employee_id,
        employee_name,
        department,
        salary
    FROM employees
)
SELECT *
FROM employee_data;


-- ------------------------------------------------------------
-- 2. CTE for high-salary employees
-- ------------------------------------------------------------

WITH high_salary_employees AS (
    SELECT
        employee_name,
        department,
        salary
    FROM employees
    WHERE salary >= 70000
)
SELECT *
FROM high_salary_employees;


-- ------------------------------------------------------------
-- 3. CTE for Engineering employees
-- ------------------------------------------------------------

WITH engineering_team AS (
    SELECT
        employee_id,
        employee_name,
        job_role,
        salary
    FROM employees
    WHERE department = 'Engineering'
)
SELECT *
FROM engineering_team;


-- ------------------------------------------------------------
-- 4. CTE for high-performing students
-- ------------------------------------------------------------

WITH high_performers AS (
    SELECT
        student_name,
        department,
        score
    FROM student_scores
    WHERE score >= 85
)
SELECT *
FROM high_performers;


-- ------------------------------------------------------------
-- 5. Department average salaries
-- ------------------------------------------------------------

WITH department_average AS (
    SELECT
        department,
        ROUND(AVG(salary), 2) AS average_salary
    FROM employees
    GROUP BY department
)
SELECT *
FROM department_average;


-- ------------------------------------------------------------
-- 6. Filter aggregated CTE results
-- ------------------------------------------------------------

WITH department_average AS (
    SELECT
        department,
        ROUND(AVG(salary), 2) AS average_salary
    FROM employees
    GROUP BY department
)
SELECT *
FROM department_average
WHERE average_salary > 60000;


-- ------------------------------------------------------------
-- 7. Department salary statistics
-- ------------------------------------------------------------

WITH department_stats AS (
    SELECT
        department,
        COUNT(*) AS total_employees,
        ROUND(AVG(salary), 2) AS average_salary,
        MIN(salary) AS lowest_salary,
        MAX(salary) AS highest_salary
    FROM employees
    GROUP BY department
)
SELECT *
FROM department_stats;


-- ------------------------------------------------------------
-- 8. Sort CTE results
-- ------------------------------------------------------------

WITH department_stats AS (
    SELECT
        department,
        ROUND(AVG(salary), 2) AS average_salary
    FROM employees
    GROUP BY department
)
SELECT *
FROM department_stats
ORDER BY average_salary DESC;


-- ------------------------------------------------------------
-- 9. Student department averages
-- ------------------------------------------------------------

WITH student_average AS (
    SELECT
        department,
        ROUND(AVG(score), 2) AS average_score
    FROM student_scores
    GROUP BY department
)
SELECT *
FROM student_average;


-- ------------------------------------------------------------
-- 10. Departments averaging at least 80
-- ------------------------------------------------------------

WITH student_average AS (
    SELECT
        department,
        ROUND(AVG(score), 2) AS average_score
    FROM student_scores
    GROUP BY department
)
SELECT *
FROM student_average
WHERE average_score >= 80;


-- ------------------------------------------------------------
-- 11. Join employees with department average
-- ------------------------------------------------------------

WITH department_average AS (
    SELECT
        department,
        ROUND(AVG(salary), 2) AS average_salary
    FROM employees
    GROUP BY department
)

SELECT
    e.employee_name,
    e.department,
    e.salary,
    d.average_salary

FROM employees AS e

JOIN department_average AS d
    ON e.department = d.department;


-- ------------------------------------------------------------
-- 12. Employees above department average
-- ------------------------------------------------------------

WITH department_average AS (
    SELECT
        department,
        AVG(salary) AS average_salary
    FROM employees
    GROUP BY department
)

SELECT
    e.employee_name,
    e.department,
    e.salary,
    ROUND(d.average_salary, 2)
        AS department_average

FROM employees AS e

JOIN department_average AS d
    ON e.department = d.department

WHERE e.salary > d.average_salary;


-- ------------------------------------------------------------
-- 13. Employees below department average
-- ------------------------------------------------------------

WITH department_average AS (
    SELECT
        department,
        AVG(salary) AS average_salary
    FROM employees
    GROUP BY department
)

SELECT
    e.employee_name,
    e.department,
    e.salary,
    ROUND(d.average_salary, 2)
        AS department_average

FROM employees AS e

JOIN department_average AS d
    ON e.department = d.department

WHERE e.salary < d.average_salary;


-- ------------------------------------------------------------
-- 14. Students above department average
-- ------------------------------------------------------------

WITH department_average AS (
    SELECT
        department,
        AVG(score) AS average_score
    FROM student_scores
    GROUP BY department
)

SELECT
    s.student_name,
    s.department,
    s.score,
    ROUND(d.average_score, 2)
        AS department_average

FROM student_scores AS s

JOIN department_average AS d
    ON s.department = d.department

WHERE s.score > d.average_score;


-- ------------------------------------------------------------
-- 15. Department employee counts
-- ------------------------------------------------------------

WITH department_counts AS (
    SELECT
        department,
        COUNT(*) AS employee_count
    FROM employees
    GROUP BY department
)
SELECT *
FROM department_counts
ORDER BY employee_count DESC;


-- ------------------------------------------------------------
-- 16. Multiple CTEs
-- ------------------------------------------------------------

WITH
department_salary AS (
    SELECT
        department,
        ROUND(AVG(salary), 2) AS average_salary
    FROM employees
    GROUP BY department
),

department_count AS (
    SELECT
        department,
        COUNT(*) AS employee_count
    FROM employees
    GROUP BY department
)

SELECT
    s.department,
    s.average_salary,
    c.employee_count

FROM department_salary AS s

JOIN department_count AS c
    ON s.department = c.department;


-- ------------------------------------------------------------
-- 17. Multiple student CTEs
-- ------------------------------------------------------------

WITH
average_scores AS (
    SELECT
        department,
        ROUND(AVG(score), 2) AS average_score
    FROM student_scores
    GROUP BY department
),

highest_scores AS (
    SELECT
        department,
        MAX(score) AS highest_score
    FROM student_scores
    GROUP BY department
)

SELECT
    a.department,
    a.average_score,
    h.highest_score

FROM average_scores AS a

JOIN highest_scores AS h
    ON a.department = h.department;


-- ------------------------------------------------------------
-- 18. Chained CTE
-- ------------------------------------------------------------

WITH department_average AS (
    SELECT
        department,
        AVG(salary) AS average_salary
    FROM employees
    GROUP BY department
),

high_cost_departments AS (
    SELECT
        department,
        ROUND(average_salary, 2)
            AS average_salary
    FROM department_average
    WHERE average_salary >= 70000
)

SELECT *
FROM high_cost_departments;


-- ------------------------------------------------------------
-- 19. Three-step CTE pipeline
-- ------------------------------------------------------------

WITH department_stats AS (
    SELECT
        department,
        COUNT(*) AS employee_count,
        AVG(salary) AS average_salary
    FROM employees
    GROUP BY department
),

filtered_departments AS (
    SELECT *
    FROM department_stats
    WHERE employee_count >= 2
),

final_report AS (
    SELECT
        department,
        employee_count,
        ROUND(average_salary, 2)
            AS average_salary
    FROM filtered_departments
)

SELECT *
FROM final_report
ORDER BY average_salary DESC;


-- ------------------------------------------------------------
-- 20. Highest salary by department
-- ------------------------------------------------------------

WITH department_maximum AS (
    SELECT
        department,
        MAX(salary) AS highest_salary
    FROM employees
    GROUP BY department
)

SELECT
    e.employee_name,
    e.department,
    e.salary

FROM employees AS e

JOIN department_maximum AS d
    ON e.department = d.department
   AND e.salary = d.highest_salary;


-- ------------------------------------------------------------
-- 21. Lowest salary by department
-- ------------------------------------------------------------

WITH department_minimum AS (
    SELECT
        department,
        MIN(salary) AS lowest_salary
    FROM employees
    GROUP BY department
)

SELECT
    e.employee_name,
    e.department,
    e.salary

FROM employees AS e

JOIN department_minimum AS d
    ON e.department = d.department
   AND e.salary = d.lowest_salary;


-- ------------------------------------------------------------
-- 22. Highest-scoring student per department
-- ------------------------------------------------------------

WITH department_maximum AS (
    SELECT
        department,
        MAX(score) AS highest_score
    FROM student_scores
    GROUP BY department
)

SELECT
    s.student_name,
    s.department,
    s.score

FROM student_scores AS s

JOIN department_maximum AS d
    ON s.department = d.department
   AND s.score = d.highest_score;


-- ------------------------------------------------------------
-- 23. Employees with salary difference from
-- department average
-- ------------------------------------------------------------

WITH department_average AS (
    SELECT
        department,
        AVG(salary) AS average_salary
    FROM employees
    GROUP BY department
)

SELECT
    e.employee_name,
    e.department,
    e.salary,

    ROUND(
        d.average_salary,
        2
    ) AS department_average,

    ROUND(
        e.salary - d.average_salary,
        2
    ) AS difference_from_average

FROM employees AS e

JOIN department_average AS d
    ON e.department = d.department

ORDER BY difference_from_average DESC;


-- ------------------------------------------------------------
-- 24. Student score difference from average
-- ------------------------------------------------------------

WITH department_average AS (
    SELECT
        department,
        AVG(score) AS average_score
    FROM student_scores
    GROUP BY department
)

SELECT
    s.student_name,
    s.department,
    s.score,

    ROUND(
        d.average_score,
        2
    ) AS department_average,

    ROUND(
        s.score - d.average_score,
        2
    ) AS difference_from_average

FROM student_scores AS s

JOIN department_average AS d
    ON s.department = d.department;


-- ------------------------------------------------------------
-- 25. Project assignment summary
-- ------------------------------------------------------------

WITH project_counts AS (
    SELECT
        student_id,
        COUNT(*) AS project_count
    FROM student_projects
    GROUP BY student_id
)

SELECT
    s.student_id,
    s.name,
    COALESCE(p.project_count, 0)
        AS project_count

FROM students AS s

LEFT JOIN project_counts AS p
    ON s.student_id = p.student_id;


-- ------------------------------------------------------------
-- 26. Students with no projects using CTE
-- ------------------------------------------------------------

WITH project_counts AS (
    SELECT
        student_id,
        COUNT(*) AS project_count
    FROM student_projects
    GROUP BY student_id
)

SELECT
    s.student_id,
    s.name

FROM students AS s

LEFT JOIN project_counts AS p
    ON s.student_id = p.student_id

WHERE p.student_id IS NULL;


-- ------------------------------------------------------------
-- 27. Manager report using CTE
-- ------------------------------------------------------------

WITH manager_stats AS (
    SELECT
        manager_id,
        COUNT(*) AS direct_reports
    FROM employees
    WHERE manager_id IS NOT NULL
    GROUP BY manager_id
)

SELECT
    e.employee_id,
    e.employee_name,
    e.job_role,
    m.direct_reports

FROM employees AS e

JOIN manager_stats AS m
    ON e.employee_id = m.manager_id

ORDER BY m.direct_reports DESC;


-- ------------------------------------------------------------
-- 28. Salary-category summary using a CTE
-- ------------------------------------------------------------

WITH salary_categories AS (
    SELECT
        employee_name,
        department,
        salary,

        CASE
            WHEN salary >= 80000
                THEN 'High Salary'

            WHEN salary >= 60000
                THEN 'Medium Salary'

            ELSE 'Entry Salary'
        END AS salary_category

    FROM employees
)

SELECT
    salary_category,
    COUNT(*) AS employee_count,
    ROUND(AVG(salary), 2)
        AS average_salary

FROM salary_categories

GROUP BY salary_category
ORDER BY average_salary DESC;


-- ------------------------------------------------------------
-- 29. Employee data-quality CTE
-- ------------------------------------------------------------

WITH data_quality AS (
    SELECT
        employee_id,

        CASE
            WHEN employee_name IS NULL
                 OR TRIM(employee_name) = ''
            THEN 1
            ELSE 0
        END AS missing_name,

        CASE
            WHEN department IS NULL
                 OR TRIM(department) = ''
            THEN 1
            ELSE 0
        END AS missing_department,

        CASE
            WHEN salary IS NULL
            THEN 1
            ELSE 0
        END AS missing_salary

    FROM employees
)

SELECT
    COUNT(*) AS total_records,
    SUM(missing_name) AS missing_names,
    SUM(missing_department)
        AS missing_departments,
    SUM(missing_salary)
        AS missing_salaries

FROM data_quality;


-- ------------------------------------------------------------
-- 30. Final multi-step employee analytics report
-- ------------------------------------------------------------

WITH department_stats AS (
    SELECT
        department,
        COUNT(*) AS total_employees,
        AVG(salary) AS average_salary,
        MIN(salary) AS minimum_salary,
        MAX(salary) AS maximum_salary
    FROM employees
    GROUP BY department
),

department_report AS (
    SELECT
        department,
        total_employees,

        ROUND(
            average_salary,
            2
        ) AS average_salary,

        minimum_salary,
        maximum_salary,

        maximum_salary - minimum_salary
            AS salary_range

    FROM department_stats
)

SELECT
    department,
    total_employees,
    average_salary,
    minimum_salary,
    maximum_salary,
    salary_range

FROM department_report

ORDER BY average_salary DESC;