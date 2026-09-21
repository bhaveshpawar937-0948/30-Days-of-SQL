-- ============================================================
-- 30 Days of SQL
-- Day 14: CASE Expressions & Conditional Logic
-- Author: Bhavesh Pawar
-- ============================================================

USE sql_30_days;


-- ------------------------------------------------------------
-- 1. Classify employees by salary
-- ------------------------------------------------------------

SELECT
    employee_name,
    salary,
    CASE
        WHEN salary >= 80000 THEN 'High Salary'
        WHEN salary >= 60000 THEN 'Medium Salary'
        ELSE 'Entry Salary'
    END AS salary_category
FROM employees;


-- ------------------------------------------------------------
-- 2. Classify student performance
-- ------------------------------------------------------------

SELECT
    student_name,
    score,
    CASE
        WHEN score >= 90 THEN 'Excellent'
        WHEN score >= 80 THEN 'Very Good'
        WHEN score >= 70 THEN 'Good'
        WHEN score >= 60 THEN 'Average'
        ELSE 'Needs Improvement'
    END AS performance
FROM student_scores;


-- ------------------------------------------------------------
-- 3. Create letter grades
-- ------------------------------------------------------------

SELECT
    student_name,
    score,
    CASE
        WHEN score >= 90 THEN 'A'
        WHEN score >= 80 THEN 'B'
        WHEN score >= 70 THEN 'C'
        WHEN score >= 60 THEN 'D'
        ELSE 'F'
    END AS grade
FROM student_scores;


-- ------------------------------------------------------------
-- 4. Simple CASE for employee departments
-- ------------------------------------------------------------

SELECT
    employee_name,
    department,
    CASE department
        WHEN 'Engineering' THEN 'Technical Team'
        WHEN 'Analytics' THEN 'Data Team'
        WHEN 'Management' THEN 'Leadership Team'
        ELSE 'Other Team'
    END AS team_category
FROM employees;


-- ------------------------------------------------------------
-- 5. Categorize job levels using salary
-- ------------------------------------------------------------

SELECT
    employee_name,
    job_role,
    salary,
    CASE
        WHEN salary >= 90000 THEN 'Leadership'
        WHEN salary >= 70000 THEN 'Senior Level'
        WHEN salary >= 50000 THEN 'Mid Level'
        ELSE 'Junior Level'
    END AS job_level
FROM employees;


-- ------------------------------------------------------------
-- 6. Combine department and salary conditions
-- ------------------------------------------------------------

SELECT
    employee_name,
    department,
    salary,
    CASE
        WHEN department = 'Engineering'
             AND salary >= 70000
            THEN 'Senior Technical'

        WHEN department = 'Engineering'
            THEN 'Technical'

        WHEN department = 'Analytics'
             AND salary >= 70000
            THEN 'Senior Analytics'

        WHEN department = 'Analytics'
            THEN 'Analytics'

        ELSE 'Other'
    END AS employee_category
FROM employees;


-- ------------------------------------------------------------
-- 7. Classify students using multiple conditions
-- ------------------------------------------------------------

SELECT
    student_name,
    department,
    score,
    CASE
        WHEN score >= 85
             AND department = 'Data Science'
            THEN 'Top Data Science Performer'

        WHEN score >= 85
            THEN 'Top Performer'

        WHEN score >= 70
            THEN 'Good Performer'

        ELSE 'Developing'
    END AS student_category
FROM student_scores;


-- ------------------------------------------------------------
-- 8. Pass / Fail classification
-- ------------------------------------------------------------

SELECT
    student_name,
    score,
    CASE
        WHEN score >= 60 THEN 'Pass'
        ELSE 'Fail'
    END AS result
FROM student_scores;


-- ------------------------------------------------------------
-- 9. Salary comparison against company average
-- ------------------------------------------------------------

SELECT
    employee_name,
    salary,
    CASE
        WHEN salary > (SELECT AVG(salary) FROM employees)
            THEN 'Above Average'

        WHEN salary < (SELECT AVG(salary) FROM employees)
            THEN 'Below Average'

        ELSE 'Average'
    END AS salary_position
FROM employees;


-- ------------------------------------------------------------
-- 10. Department-average salary classification
-- ------------------------------------------------------------

SELECT
    e.employee_name,
    e.department,
    e.salary,
    CASE
        WHEN e.salary > (
            SELECT AVG(e2.salary)
            FROM employees AS e2
            WHERE e2.department = e.department
        )
        THEN 'Above Department Average'

        WHEN e.salary < (
            SELECT AVG(e2.salary)
            FROM employees AS e2
            WHERE e2.department = e.department
        )
        THEN 'Below Department Average'

        ELSE 'Department Average'
    END AS department_salary_position
FROM employees AS e;


-- ------------------------------------------------------------
-- 11. Label managers and individual contributors
-- ------------------------------------------------------------

SELECT
    e.employee_name,
    e.job_role,
    CASE
        WHEN EXISTS (
            SELECT 1
            FROM employees AS subordinate
            WHERE subordinate.manager_id = e.employee_id
        )
        THEN 'Manager'
        ELSE 'Individual Contributor'
    END AS employee_type
FROM employees AS e;


-- ------------------------------------------------------------
-- 12. Label students according to project assignment
-- ------------------------------------------------------------

SELECT
    s.student_id,
    s.name,
    CASE
        WHEN EXISTS (
            SELECT 1
            FROM student_projects AS p
            WHERE p.student_id = s.student_id
        )
        THEN 'Project Assigned'
        ELSE 'No Project'
    END AS project_status
FROM students AS s;


-- ------------------------------------------------------------
-- 13. Count high-salary employees
-- ------------------------------------------------------------

SELECT
    SUM(
        CASE
            WHEN salary >= 70000 THEN 1
            ELSE 0
        END
    ) AS high_salary_employees
FROM employees;


-- ------------------------------------------------------------
-- 14. Count employees by salary band
-- ------------------------------------------------------------

SELECT
    SUM(
        CASE
            WHEN salary >= 80000 THEN 1
            ELSE 0
        END
    ) AS high_salary,

    SUM(
        CASE
            WHEN salary >= 60000
                 AND salary < 80000
            THEN 1
            ELSE 0
        END
    ) AS medium_salary,

    SUM(
        CASE
            WHEN salary < 60000 THEN 1
            ELSE 0
        END
    ) AS entry_salary
FROM employees;


-- ------------------------------------------------------------
-- 15. Conditional aggregation by department
-- ------------------------------------------------------------

SELECT
    department,

    SUM(
        CASE
            WHEN salary >= 70000 THEN 1
            ELSE 0
        END
    ) AS high_salary_employees,

    SUM(
        CASE
            WHEN salary < 70000 THEN 1
            ELSE 0
        END
    ) AS other_employees

FROM employees
GROUP BY department;


-- ------------------------------------------------------------
-- 16. Count passing and failing students
-- ------------------------------------------------------------

SELECT
    SUM(
        CASE
            WHEN score >= 60 THEN 1
            ELSE 0
        END
    ) AS passed_students,

    SUM(
        CASE
            WHEN score < 60 THEN 1
            ELSE 0
        END
    ) AS failed_students

FROM student_scores;


-- ------------------------------------------------------------
-- 17. Count performance categories by department
-- ------------------------------------------------------------

SELECT
    department,

    SUM(
        CASE
            WHEN score >= 85 THEN 1
            ELSE 0
        END
    ) AS top_performers,

    SUM(
        CASE
            WHEN score >= 70
                 AND score < 85
            THEN 1
            ELSE 0
        END
    ) AS good_performers,

    SUM(
        CASE
            WHEN score < 70 THEN 1
            ELSE 0
        END
    ) AS developing_students

FROM student_scores
GROUP BY department;


-- ------------------------------------------------------------
-- 18. Calculate payroll by department condition
-- ------------------------------------------------------------

SELECT
    SUM(
        CASE
            WHEN department = 'Engineering'
            THEN salary
            ELSE 0
        END
    ) AS engineering_payroll,

    SUM(
        CASE
            WHEN department = 'Analytics'
            THEN salary
            ELSE 0
        END
    ) AS analytics_payroll,

    SUM(
        CASE
            WHEN department = 'Management'
            THEN salary
            ELSE 0
        END
    ) AS management_payroll

FROM employees;


-- ------------------------------------------------------------
-- 19. Conditional average salary
-- ------------------------------------------------------------

SELECT
    AVG(
        CASE
            WHEN department = 'Engineering'
            THEN salary
        END
    ) AS engineering_average_salary,

    AVG(
        CASE
            WHEN department = 'Analytics'
            THEN salary
        END
    ) AS analytics_average_salary

FROM employees;


-- ------------------------------------------------------------
-- 20. Custom department sorting
-- ------------------------------------------------------------

SELECT
    employee_name,
    department,
    job_role
FROM employees
ORDER BY
    CASE department
        WHEN 'Management' THEN 1
        WHEN 'Engineering' THEN 2
        WHEN 'Analytics' THEN 3
        ELSE 4
    END,
    employee_name;


-- ------------------------------------------------------------
-- 21. Sort students by custom performance priority
-- ------------------------------------------------------------

SELECT
    student_name,
    score,
    CASE
        WHEN score >= 90 THEN 'Excellent'
        WHEN score >= 75 THEN 'Good'
        WHEN score >= 60 THEN 'Average'
        ELSE 'Needs Improvement'
    END AS performance
FROM student_scores
ORDER BY
    CASE
        WHEN score >= 90 THEN 1
        WHEN score >= 75 THEN 2
        WHEN score >= 60 THEN 3
        ELSE 4
    END,
    score DESC;


-- ------------------------------------------------------------
-- 22. Employee salary bands with readable ranges
-- ------------------------------------------------------------

SELECT
    employee_name,
    salary,
    CASE
        WHEN salary >= 90000 THEN '90K+'
        WHEN salary >= 70000 THEN '70K - 89K'
        WHEN salary >= 50000 THEN '50K - 69K'
        ELSE 'Below 50K'
    END AS salary_band
FROM employees;


-- ------------------------------------------------------------
-- 23. Count managers and individual contributors
-- ------------------------------------------------------------

SELECT
    SUM(
        CASE
            WHEN EXISTS (
                SELECT 1
                FROM employees AS subordinate
                WHERE subordinate.manager_id =
                      employees.employee_id
            )
            THEN 1
            ELSE 0
        END
    ) AS managers,

    SUM(
        CASE
            WHEN NOT EXISTS (
                SELECT 1
                FROM employees AS subordinate
                WHERE subordinate.manager_id =
                      employees.employee_id
            )
            THEN 1
            ELSE 0
        END
    ) AS individual_contributors

FROM employees;


-- ------------------------------------------------------------
-- 24. Count students with and without projects
-- ------------------------------------------------------------

SELECT
    SUM(
        CASE
            WHEN EXISTS (
                SELECT 1
                FROM student_projects AS p
                WHERE p.student_id = s.student_id
            )
            THEN 1
            ELSE 0
        END
    ) AS students_with_projects,

    SUM(
        CASE
            WHEN NOT EXISTS (
                SELECT 1
                FROM student_projects AS p
                WHERE p.student_id = s.student_id
            )
            THEN 1
            ELSE 0
        END
    ) AS students_without_projects

FROM students AS s;


-- ------------------------------------------------------------
-- 25. Department salary distribution
-- ------------------------------------------------------------

SELECT
    department,

    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN salary >= 70000 THEN 1
            ELSE 0
        END
    ) AS salary_70k_plus,

    SUM(
        CASE
            WHEN salary < 70000 THEN 1
            ELSE 0
        END
    ) AS salary_below_70k

FROM employees
GROUP BY department;


-- ------------------------------------------------------------
-- 26. Calculate percentage of high-performing students
-- ------------------------------------------------------------

SELECT
    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN score >= 80 THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS high_performer_percentage
FROM student_scores;


-- ------------------------------------------------------------
-- 27. Calculate department pass percentage
-- ------------------------------------------------------------

SELECT
    department,

    COUNT(*) AS total_students,

    SUM(
        CASE
            WHEN score >= 60 THEN 1
            ELSE 0
        END
    ) AS passed_students,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN score >= 60 THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS pass_percentage

FROM student_scores
GROUP BY department;


-- ------------------------------------------------------------
-- 28. Create an employee business-status report
-- ------------------------------------------------------------

SELECT
    employee_name,
    department,
    job_role,
    salary,

    CASE
        WHEN salary >= 90000 THEN 'Leadership'
        WHEN salary >= 70000 THEN 'Senior'
        WHEN salary >= 50000 THEN 'Mid Level'
        ELSE 'Junior'
    END AS seniority,

    CASE
        WHEN manager_id IS NULL THEN 'Top Level'
        ELSE 'Reports to Manager'
    END AS hierarchy_status

FROM employees;


-- ------------------------------------------------------------
-- 29. Multi-condition performance classification
-- ------------------------------------------------------------

SELECT
    student_name,
    department,
    score,

    CASE
        WHEN score >= 90
            THEN 'Outstanding'

        WHEN score >= 80
            THEN 'Strong'

        WHEN score >= 70
            THEN 'Good'

        WHEN score >= 60
            THEN 'Satisfactory'

        ELSE 'Needs Improvement'
    END AS performance_level

FROM student_scores
ORDER BY score DESC;


-- ------------------------------------------------------------
-- 30. Final KPI-style employee report
-- ------------------------------------------------------------

SELECT
    department,

    COUNT(*) AS total_employees,

    ROUND(AVG(salary), 2) AS average_salary,

    SUM(
        CASE
            WHEN salary >= 70000 THEN 1
            ELSE 0
        END
    ) AS high_salary_count,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN salary >= 70000 THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS high_salary_percentage,

    CASE
        WHEN AVG(salary) >= 80000
            THEN 'High Cost Department'

        WHEN AVG(salary) >= 60000
            THEN 'Medium Cost Department'

        ELSE 'Lower Cost Department'
    END AS payroll_category

FROM employees
GROUP BY department
ORDER BY average_salary DESC;