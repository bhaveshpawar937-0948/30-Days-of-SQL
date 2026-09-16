-- ============================================================
-- 30 Days of SQL
-- Day 09: SELF JOIN & Hierarchical Relationships
-- Author: Bhavesh Pawar
-- ============================================================

USE sql_30_days;


-- ------------------------------------------------------------
-- Setup: Create employees table
-- manager_id references another employee in the same table
-- ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    department VARCHAR(100),
    job_role VARCHAR(100),
    salary DECIMAL(10,2),
    manager_id INT,
    FOREIGN KEY (manager_id)
        REFERENCES employees(employee_id)
);


-- ------------------------------------------------------------
-- Insert sample hierarchy
-- INSERT IGNORE allows the script to be safely rerun
-- ------------------------------------------------------------

INSERT IGNORE INTO employees
    (employee_id, employee_name, department, job_role, salary, manager_id)
VALUES
    (1, 'Ananya', 'Management', 'Director', 120000, NULL),
    (2, 'Rahul', 'Engineering', 'Engineering Manager', 90000, 1),
    (3, 'Priya', 'Analytics', 'Analytics Manager', 88000, 1),
    (4, 'Aman', 'Engineering', 'Software Engineer', 65000, 2),
    (5, 'Sneha', 'Engineering', 'Data Engineer', 70000, 2),
    (6, 'Neha', 'Analytics', 'Data Analyst', 60000, 3),
    (7, 'Arjun', 'Analytics', 'ML Engineer', 72000, 3),
    (8, 'Kavya', 'Engineering', 'Junior Developer', 48000, 4),
    (9, 'Rohan', 'Analytics', 'Junior Analyst', 45000, 6);


-- ------------------------------------------------------------
-- 1. Display every employee with their manager
-- ------------------------------------------------------------

SELECT
    e.employee_name AS employee,
    m.employee_name AS manager
FROM employees AS e
LEFT JOIN employees AS m
    ON e.manager_id = m.employee_id;


-- ------------------------------------------------------------
-- 2. Display employee role and manager role
-- ------------------------------------------------------------

SELECT
    e.employee_name AS employee,
    e.job_role AS employee_role,
    m.employee_name AS manager,
    m.job_role AS manager_role
FROM employees AS e
LEFT JOIN employees AS m
    ON e.manager_id = m.employee_id;


-- ------------------------------------------------------------
-- 3. Find employees without a manager
-- ------------------------------------------------------------

SELECT
    employee_id,
    employee_name,
    job_role
FROM employees
WHERE manager_id IS NULL;


-- ------------------------------------------------------------
-- 4. Find employees who report directly to Ananya
-- ------------------------------------------------------------

SELECT
    e.employee_name AS employee,
    e.job_role
FROM employees AS e
JOIN employees AS m
    ON e.manager_id = m.employee_id
WHERE m.employee_name = 'Ananya';


-- ------------------------------------------------------------
-- 5. Find employees reporting to Rahul
-- ------------------------------------------------------------

SELECT
    e.employee_name AS employee,
    e.job_role
FROM employees AS e
JOIN employees AS m
    ON e.manager_id = m.employee_id
WHERE m.employee_name = 'Rahul';


-- ------------------------------------------------------------
-- 6. Display manager-employee pairs
-- ------------------------------------------------------------

SELECT
    m.employee_name AS manager,
    e.employee_name AS employee
FROM employees AS e
JOIN employees AS m
    ON e.manager_id = m.employee_id
ORDER BY m.employee_name;


-- ------------------------------------------------------------
-- 7. Find employees who manage at least one person
-- ------------------------------------------------------------

SELECT DISTINCT
    m.employee_id,
    m.employee_name,
    m.job_role
FROM employees AS e
JOIN employees AS m
    ON e.manager_id = m.employee_id;


-- ------------------------------------------------------------
-- 8. Find employees who do not manage anyone
-- ------------------------------------------------------------

SELECT
    e.employee_id,
    e.employee_name,
    e.job_role
FROM employees AS e
LEFT JOIN employees AS subordinate
    ON e.employee_id = subordinate.manager_id
WHERE subordinate.employee_id IS NULL;


-- ------------------------------------------------------------
-- 9. Display employee, manager and department
-- ------------------------------------------------------------

SELECT
    e.employee_name AS employee,
    e.department AS employee_department,
    m.employee_name AS manager,
    m.department AS manager_department
FROM employees AS e
LEFT JOIN employees AS m
    ON e.manager_id = m.employee_id;


-- ------------------------------------------------------------
-- 10. Compare employee salary with manager salary
-- ------------------------------------------------------------

SELECT
    e.employee_name AS employee,
    e.salary AS employee_salary,
    m.employee_name AS manager,
    m.salary AS manager_salary
FROM employees AS e
JOIN employees AS m
    ON e.manager_id = m.employee_id;


-- ------------------------------------------------------------
-- 11. Find employees earning more than their manager
-- ------------------------------------------------------------

SELECT
    e.employee_name AS employee,
    e.salary AS employee_salary,
    m.employee_name AS manager,
    m.salary AS manager_salary
FROM employees AS e
JOIN employees AS m
    ON e.manager_id = m.employee_id
WHERE e.salary > m.salary;


-- ------------------------------------------------------------
-- 12. Find employees in the same department
-- Avoid matching a row with itself
-- ------------------------------------------------------------

SELECT
    e1.employee_name AS employee_1,
    e2.employee_name AS employee_2,
    e1.department
FROM employees AS e1
JOIN employees AS e2
    ON e1.department = e2.department
   AND e1.employee_id < e2.employee_id
ORDER BY e1.department;


-- ------------------------------------------------------------
-- 13. Display employees one level below management
-- ------------------------------------------------------------

SELECT
    e.employee_name AS employee,
    m.employee_name AS manager,
    m.job_role AS manager_role
FROM employees AS e
JOIN employees AS m
    ON e.manager_id = m.employee_id
WHERE m.manager_id IS NULL;


-- ------------------------------------------------------------
-- 14. Find employees and their manager IDs
-- ------------------------------------------------------------

SELECT
    e.employee_id,
    e.employee_name,
    e.manager_id,
    m.employee_name AS manager_name
FROM employees AS e
LEFT JOIN employees AS m
    ON e.manager_id = m.employee_id;


-- ------------------------------------------------------------
-- 15. Show hierarchy with readable top-level manager
-- ------------------------------------------------------------

SELECT
    e.employee_name AS employee,
    e.job_role,
    COALESCE(m.employee_name, 'Top Level') AS reports_to
FROM employees AS e
LEFT JOIN employees AS m
    ON e.manager_id = m.employee_id
ORDER BY e.employee_id;


-- ------------------------------------------------------------
-- 16. Find pairs of employees with the same manager
-- ------------------------------------------------------------

SELECT
    e1.employee_name AS employee_1,
    e2.employee_name AS employee_2,
    m.employee_name AS common_manager
FROM employees AS e1
JOIN employees AS e2
    ON e1.manager_id = e2.manager_id
   AND e1.employee_id < e2.employee_id
JOIN employees AS m
    ON e1.manager_id = m.employee_id;


-- ------------------------------------------------------------
-- 17. Find all direct reports of Analytics Manager
-- ------------------------------------------------------------

SELECT
    e.employee_name,
    e.job_role,
    m.employee_name AS manager
FROM employees AS e
JOIN employees AS m
    ON e.manager_id = m.employee_id
WHERE m.job_role = 'Analytics Manager';


-- ------------------------------------------------------------
-- 18. Create an employee-manager salary report
-- ------------------------------------------------------------

SELECT
    e.employee_name AS employee,
    e.job_role,
    e.salary,
    COALESCE(m.employee_name, 'No Manager') AS manager,
    m.salary AS manager_salary
FROM employees AS e
LEFT JOIN employees AS m
    ON e.manager_id = m.employee_id
ORDER BY e.employee_id;


-- ------------------------------------------------------------
-- 19. Find employee pairs from the same department
-- where one earns more than the other
-- ------------------------------------------------------------

SELECT
    e1.employee_name AS higher_paid_employee,
    e2.employee_name AS lower_paid_employee,
    e1.department,
    e1.salary AS higher_salary,
    e2.salary AS lower_salary
FROM employees AS e1
JOIN employees AS e2
    ON e1.department = e2.department
   AND e1.salary > e2.salary;


-- ------------------------------------------------------------
-- 20. Final organizational relationship report
-- ------------------------------------------------------------

SELECT
    e.employee_id,
    e.employee_name,
    e.department,
    e.job_role,
    e.salary,
    COALESCE(m.employee_name, 'Top Level') AS manager,
    COALESCE(m.job_role, 'No Manager') AS manager_role
FROM employees AS e
LEFT JOIN employees AS m
    ON e.manager_id = m.employee_id
ORDER BY e.employee_id;