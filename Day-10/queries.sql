-- ============================================================
-- 30 Days of SQL
-- Day 10: CROSS JOIN & Cartesian Products
-- Author: Bhavesh Pawar
-- ============================================================

USE sql_30_days;


-- ------------------------------------------------------------
-- Setup: Create available courses table
-- ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS available_courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    department VARCHAR(100)
);


INSERT IGNORE INTO available_courses
    (course_id, course_name, department)
VALUES
    (201, 'Python Programming', 'Computer Science'),
    (202, 'Machine Learning', 'Artificial Intelligence'),
    (203, 'Data Analytics', 'Data Science');


-- ------------------------------------------------------------
-- Setup: Create shift table
-- ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS work_shifts (
    shift_id INT PRIMARY KEY,
    shift_name VARCHAR(50)
);


INSERT IGNORE INTO work_shifts
    (shift_id, shift_name)
VALUES
    (1, 'Morning'),
    (2, 'Evening'),
    (3, 'Night');


-- ------------------------------------------------------------
-- 1. Basic CROSS JOIN
-- Every student paired with every available course
-- ------------------------------------------------------------

SELECT
    s.student_id,
    s.name,
    c.course_name
FROM students AS s
CROSS JOIN available_courses AS c;


-- ------------------------------------------------------------
-- 2. Count expected student-course combinations
-- ------------------------------------------------------------

SELECT
    (SELECT COUNT(*) FROM students) *
    (SELECT COUNT(*) FROM available_courses)
    AS expected_combinations;


-- ------------------------------------------------------------
-- 3. Count actual CROSS JOIN rows
-- ------------------------------------------------------------

SELECT
    COUNT(*) AS actual_combinations
FROM students AS s
CROSS JOIN available_courses AS c;


-- ------------------------------------------------------------
-- 4. Display complete student-course matrix
-- ------------------------------------------------------------

SELECT
    s.name AS student,
    s.department AS student_department,
    c.course_name,
    c.department AS course_department
FROM students AS s
CROSS JOIN available_courses AS c
ORDER BY s.student_id, c.course_id;


-- ------------------------------------------------------------
-- 5. Generate combinations only for matching departments
-- ------------------------------------------------------------

SELECT
    s.name,
    s.department,
    c.course_name
FROM students AS s
CROSS JOIN available_courses AS c
WHERE s.department = c.department;


-- ------------------------------------------------------------
-- 6. Generate combinations for non-matching departments
-- ------------------------------------------------------------

SELECT
    s.name,
    s.department AS student_department,
    c.course_name,
    c.department AS course_department
FROM students AS s
CROSS JOIN available_courses AS c
WHERE s.department <> c.department;


-- ------------------------------------------------------------
-- 7. Pair every employee with every work shift
-- ------------------------------------------------------------

SELECT
    e.employee_name,
    w.shift_name
FROM employees AS e
CROSS JOIN work_shifts AS w;


-- ------------------------------------------------------------
-- 8. Count employee-shift combinations
-- ------------------------------------------------------------

SELECT
    COUNT(*) AS total_employee_shift_combinations
FROM employees AS e
CROSS JOIN work_shifts AS w;


-- ------------------------------------------------------------
-- 9. Generate shift options for Engineering employees
-- ------------------------------------------------------------

SELECT
    e.employee_name,
    e.department,
    w.shift_name
FROM employees AS e
CROSS JOIN work_shifts AS w
WHERE e.department = 'Engineering';


-- ------------------------------------------------------------
-- 10. Generate shift options for Analytics employees
-- ------------------------------------------------------------

SELECT
    e.employee_name,
    e.job_role,
    w.shift_name
FROM employees AS e
CROSS JOIN work_shifts AS w
WHERE e.department = 'Analytics';


-- ------------------------------------------------------------
-- 11. Create product table for variant generation
-- ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100)
);


INSERT IGNORE INTO products
    (product_id, product_name)
VALUES
    (301, 'T-Shirt'),
    (302, 'Hoodie'),
    (303, 'Jacket');


-- ------------------------------------------------------------
-- 12. Create product sizes
-- ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS product_sizes (
    size_id INT PRIMARY KEY,
    size_name VARCHAR(20)
);


INSERT IGNORE INTO product_sizes
    (size_id, size_name)
VALUES
    (1, 'Small'),
    (2, 'Medium'),
    (3, 'Large');


-- ------------------------------------------------------------
-- 13. Generate all product-size combinations
-- ------------------------------------------------------------

SELECT
    p.product_name,
    s.size_name
FROM products AS p
CROSS JOIN product_sizes AS s;


-- ------------------------------------------------------------
-- 14. Count possible product variants
-- ------------------------------------------------------------

SELECT
    COUNT(*) AS total_product_variants
FROM products AS p
CROSS JOIN product_sizes AS s;


-- ------------------------------------------------------------
-- 15. Add color combinations
-- ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS product_colors (
    color_id INT PRIMARY KEY,
    color_name VARCHAR(30)
);


INSERT IGNORE INTO product_colors
    (color_id, color_name)
VALUES
    (1, 'Black'),
    (2, 'Blue'),
    (3, 'White');


-- ------------------------------------------------------------
-- 16. Generate product × size × color combinations
-- ------------------------------------------------------------

SELECT
    p.product_name,
    s.size_name,
    c.color_name
FROM products AS p
CROSS JOIN product_sizes AS s
CROSS JOIN product_colors AS c;


-- ------------------------------------------------------------
-- 17. Count all three-way combinations
-- ------------------------------------------------------------

SELECT
    COUNT(*) AS total_variants
FROM products AS p
CROSS JOIN product_sizes AS s
CROSS JOIN product_colors AS c;


-- ------------------------------------------------------------
-- 18. Generate only Large product variants
-- ------------------------------------------------------------

SELECT
    p.product_name,
    s.size_name,
    c.color_name
FROM products AS p
CROSS JOIN product_sizes AS s
CROSS JOIN product_colors AS c
WHERE s.size_name = 'Large';


-- ------------------------------------------------------------
-- 19. Generate only Black product variants
-- ------------------------------------------------------------

SELECT
    p.product_name,
    s.size_name,
    c.color_name
FROM products AS p
CROSS JOIN product_sizes AS s
CROSS JOIN product_colors AS c
WHERE c.color_name = 'Black';


-- ------------------------------------------------------------
-- 20. Final scenario matrix
-- Every employee paired with every shift
-- with a readable scenario description
-- ------------------------------------------------------------

SELECT
    e.employee_name,
    e.job_role,
    w.shift_name,
    CONCAT(
        e.employee_name,
        ' - ',
        w.shift_name,
        ' Shift'
    ) AS schedule_scenario
FROM employees AS e
CROSS JOIN work_shifts AS w
ORDER BY e.employee_id, w.shift_id;