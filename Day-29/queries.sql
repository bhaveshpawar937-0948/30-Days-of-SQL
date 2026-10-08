-- ============================================================
-- 30 Days of SQL
-- Day 29: Constraints & Advanced Data Integrity
-- Author: Bhavesh Pawar
-- Database: MySQL 8.0.16+
-- ============================================================

USE sql_30_days;


-- ============================================================
-- SECTION 1: PREPARE ISOLATED PRACTICE TABLES
-- ============================================================

-- These tables are separate from previous challenge tables.
-- Running this script again resets only the Day 29 tables.


-- ------------------------------------------------------------
-- 1. Remove previous practice tables in dependency order
-- ------------------------------------------------------------

DROP TABLE IF EXISTS d29_assignments;

DROP TABLE IF EXISTS d29_projects;

DROP TABLE IF EXISTS d29_employees;

DROP TABLE IF EXISTS d29_departments;


-- ============================================================
-- SECTION 2: CREATE TABLES WITH CONSTRAINTS
-- ============================================================


-- ------------------------------------------------------------
-- 2. Create departments table
-- ------------------------------------------------------------

CREATE TABLE d29_departments (

    department_id INT PRIMARY KEY,

    department_code VARCHAR(12) NOT NULL,

    department_name VARCHAR(60) NOT NULL,

    CONSTRAINT uq_d29_department_code
        UNIQUE (department_code),

    CONSTRAINT chk_d29_department_name
        CHECK (
            CHAR_LENGTH(
                TRIM(department_name)
            ) > 0
        )

) ENGINE = InnoDB;


-- ------------------------------------------------------------
-- 3. Create employees table with advanced constraints
-- ------------------------------------------------------------

CREATE TABLE d29_employees (

    employee_id INT PRIMARY KEY,

    full_name VARCHAR(80) NOT NULL,

    email VARCHAR(120) NOT NULL,

    department_id INT NULL,

    base_salary DECIMAL(10,2) NOT NULL,

    bonus DECIMAL(10,2) NOT NULL DEFAULT 0,

    employment_status VARCHAR(12)
        NOT NULL DEFAULT 'ACTIVE',

    joined_on DATE NOT NULL,

    CONSTRAINT uq_d29_employee_email
        UNIQUE (email),

    CONSTRAINT chk_d29_base_salary
        CHECK (base_salary >= 0),

    CONSTRAINT chk_d29_bonus
        CHECK (
            bonus >= 0
            AND bonus <= base_salary
        ),

    CONSTRAINT chk_d29_employee_status
        CHECK (
            employment_status IN (
                'ACTIVE',
                'LEAVE',
                'EXITED'
            )
        ),

    CONSTRAINT chk_d29_joined_on
        CHECK (
            joined_on >= '2020-01-01'
        ),

    CONSTRAINT fk_d29_employee_department
        FOREIGN KEY (department_id)
        REFERENCES d29_departments(department_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE

) ENGINE = InnoDB;


-- ------------------------------------------------------------
-- 4. Create projects table
-- ------------------------------------------------------------

CREATE TABLE d29_projects (

    project_id INT PRIMARY KEY,

    department_id INT NOT NULL,

    project_code VARCHAR(20) NOT NULL,

    project_budget DECIMAL(12,2) NOT NULL,

    CONSTRAINT uq_d29_department_project
        UNIQUE (
            department_id,
            project_code
        ),

    CONSTRAINT chk_d29_project_budget
        CHECK (project_budget > 0),

    CONSTRAINT fk_d29_project_department
        FOREIGN KEY (department_id)
        REFERENCES d29_departments(department_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE

) ENGINE = InnoDB;


-- ------------------------------------------------------------
-- 5. Create project assignments table
-- ------------------------------------------------------------

CREATE TABLE d29_assignments (

    employee_id INT NOT NULL,

    project_id INT NOT NULL,

    assigned_on DATE NOT NULL,

    hours_per_week INT NOT NULL,

    CONSTRAINT pk_d29_assignment
        PRIMARY KEY (
            employee_id,
            project_id
        ),

    CONSTRAINT chk_d29_assignment_hours
        CHECK (
            hours_per_week BETWEEN 1 AND 40
        ),

    CONSTRAINT fk_d29_assignment_employee
        FOREIGN KEY (employee_id)
        REFERENCES d29_employees(employee_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_d29_assignment_project
        FOREIGN KEY (project_id)
        REFERENCES d29_projects(project_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE

) ENGINE = InnoDB;


-- ============================================================
-- SECTION 3: INSERT VALID PRACTICE DATA
-- ============================================================


-- ------------------------------------------------------------
-- 6. Insert departments
-- ------------------------------------------------------------

INSERT INTO d29_departments (
    department_id,
    department_code,
    department_name
)
VALUES
    (10, 'ENG', 'Engineering'),
    (20, 'DATA', 'Analytics'),
    (30, 'OPS', 'Operations'),
    (40, 'TMP', 'Temporary');


-- ------------------------------------------------------------
-- 7. Insert employees
-- ------------------------------------------------------------

INSERT INTO d29_employees (
    employee_id,
    full_name,
    email,
    department_id,
    base_salary,
    bonus,
    employment_status,
    joined_on
)
VALUES

(
    1,
    'Asha Sharma',
    'asha@example.com',
    10,
    70000,
    5000,
    'ACTIVE',
    '2025-01-15'
),

(
    2,
    'Rahul Patil',
    'rahul@example.com',
    10,
    62000,
    3000,
    'ACTIVE',
    '2025-03-10'
),

(
    3,
    'Priya Singh',
    'priya@example.com',
    20,
    75000,
    4000,
    'LEAVE',
    '2024-08-20'
),

(
    4,
    'Aman Khan',
    'aman@example.com',
    30,
    50000,
    1000,
    'ACTIVE',
    '2026-02-05'
);


-- ------------------------------------------------------------
-- 8. Insert projects
-- ------------------------------------------------------------

INSERT INTO d29_projects (
    project_id,
    department_id,
    project_code,
    project_budget
)
VALUES

    (101, 10, 'API', 100000),

    (102, 20, 'PIPELINE', 200000),

    (103, 30, 'SUPPORT', 80000),

    (104, 40, 'PILOT', 15000);


-- ------------------------------------------------------------
-- 9. Insert project assignments
-- ------------------------------------------------------------

INSERT INTO d29_assignments (
    employee_id,
    project_id,
    assigned_on,
    hours_per_week
)
VALUES

    (1, 101, '2026-01-10', 20),

    (2, 101, '2026-01-12', 15),

    (3, 102, '2026-02-01', 30),

    (4, 103, '2026-02-15', 25),

    (1, 104, '2026-03-01', 5);


-- ------------------------------------------------------------
-- 10. Inspect initial practice data
-- ------------------------------------------------------------

SELECT *
FROM d29_departments;


SELECT *
FROM d29_employees;


SELECT *
FROM d29_projects;


SELECT *
FROM d29_assignments;


-- ============================================================
-- SECTION 4: UNIQUE AND COMPOSITE CONSTRAINTS
-- ============================================================


-- ------------------------------------------------------------
-- 11. Inspect unique indexes
-- ------------------------------------------------------------

SHOW INDEX
FROM d29_employees;


SHOW INDEX
FROM d29_projects;


-- ------------------------------------------------------------
-- 12. Test valid composite uniqueness
-- ------------------------------------------------------------

-- The code API already exists in Engineering.
-- The same code is allowed in Analytics.

INSERT INTO d29_projects (
    project_id,
    department_id,
    project_code,
    project_budget
)
VALUES (
    106,
    20,
    'API',
    50000
);


SELECT
    project_id,
    department_id,
    project_code,
    project_budget
FROM d29_projects
ORDER BY department_id, project_code;


-- ------------------------------------------------------------
-- 13. Duplicate email violation
-- ------------------------------------------------------------

-- This statement should fail because the email exists.
-- Uncomment only when testing the constraint.

-- INSERT INTO d29_employees (
--     employee_id,
--     full_name,
--     email,
--     department_id,
--     base_salary,
--     joined_on
-- )
-- VALUES (
--     5,
--     'Duplicate Email',
--     'asha@example.com',
--     10,
--     50000,
--     '2026-01-01'
-- );


-- ------------------------------------------------------------
-- 14. Composite UNIQUE violation
-- ------------------------------------------------------------

-- Engineering already has project code API.
-- This combination is not allowed.

-- INSERT INTO d29_projects (
--     project_id,
--     department_id,
--     project_code,
--     project_budget
-- )
-- VALUES (
--     107,
--     10,
--     'API',
--     30000
-- );


-- ============================================================
-- SECTION 5: CHECK AND NOT NULL CONSTRAINTS
-- ============================================================


-- ------------------------------------------------------------
-- 15. NOT NULL violation
-- ------------------------------------------------------------

-- A NULL employee name should be rejected.

-- INSERT INTO d29_employees (
--     employee_id,
--     full_name,
--     email,
--     department_id,
--     base_salary,
--     joined_on
-- )
-- VALUES (
--     5,
--     NULL,
--     'test@example.com',
--     10,
--     50000,
--     '2026-01-01'
-- );


-- ------------------------------------------------------------
-- 16. Negative salary violation
-- ------------------------------------------------------------

-- CHECK prevents negative salary values.

-- UPDATE d29_employees
-- SET base_salary = -5000
-- WHERE employee_id = 1;


-- ------------------------------------------------------------
-- 17. Invalid employment status
-- ------------------------------------------------------------

-- Only ACTIVE, LEAVE and EXITED are accepted.

-- UPDATE d29_employees
-- SET employment_status = 'UNKNOWN'
-- WHERE employee_id = 1;


-- ------------------------------------------------------------
-- 18. Invalid project budget
-- ------------------------------------------------------------

-- Project budgets must be greater than zero.

-- INSERT INTO d29_projects (
--     project_id,
--     department_id,
--     project_code,
--     project_budget
-- )
-- VALUES (
--     108,
--     20,
--     'INVALID',
--     -10000
-- );


-- ============================================================
-- SECTION 6: REFERENTIAL INTEGRITY
-- ============================================================


-- ------------------------------------------------------------
-- 19. Invalid foreign key example
-- ------------------------------------------------------------

-- Department 999 does not exist.
-- This insert should fail.

-- INSERT INTO d29_employees (
--     employee_id,
--     full_name,
--     email,
--     department_id,
--     base_salary,
--     joined_on
-- )
-- VALUES (
--     5,
--     'Invalid Department',
--     'invalid@example.com',
--     999,
--     50000,
--     '2026-01-01'
-- );


-- ------------------------------------------------------------
-- 20. Verify existing employee-department relationships
-- ------------------------------------------------------------

SELECT
    e.employee_id,
    e.full_name,
    e.department_id,
    d.department_name
FROM d29_employees AS e
LEFT JOIN d29_departments AS d
    ON e.department_id = d.department_id
ORDER BY e.employee_id;


-- ============================================================
-- SECTION 7: ALTER TABLE AND NAMED CONSTRAINTS
-- ============================================================


-- ------------------------------------------------------------
-- 21. Add a new email validation constraint
-- ------------------------------------------------------------

-- This is a basic shape check, not full email validation.

ALTER TABLE d29_employees
ADD CONSTRAINT chk_d29_email_format
CHECK (
    email LIKE '%_@_%._%'
);


-- ------------------------------------------------------------
-- 22. Invalid email format example
-- ------------------------------------------------------------

-- This update should fail.

-- UPDATE d29_employees
-- SET email = 'invalid-email'
-- WHERE employee_id = 1;


-- ------------------------------------------------------------
-- 23. Drop and recreate the named CHECK constraint
-- ------------------------------------------------------------

ALTER TABLE d29_employees
DROP CHECK chk_d29_email_format;


ALTER TABLE d29_employees
ADD CONSTRAINT chk_d29_email_format
CHECK (
    email LIKE '%_@_%._%'
);


-- ============================================================
-- SECTION 8: ON UPDATE CASCADE
-- ============================================================


-- ------------------------------------------------------------
-- 24. Update parent department ID
-- ------------------------------------------------------------

-- Department 10 becomes Department 11.
-- Employee and project foreign keys update automatically.

UPDATE d29_departments
SET department_id = 11
WHERE department_id = 10;


SELECT
    department_id,
    department_name
FROM d29_departments
ORDER BY department_id;


SELECT
    employee_id,
    full_name,
    department_id
FROM d29_employees
ORDER BY employee_id;


SELECT
    project_id,
    project_code,
    department_id
FROM d29_projects
ORDER BY project_id;


-- ============================================================
-- SECTION 9: ON DELETE RESTRICT
-- ============================================================


-- ------------------------------------------------------------
-- 25. Test restricted department deletion
-- ------------------------------------------------------------

-- Department 40 owns Project 104.
-- The deletion should be rejected.

-- DELETE FROM d29_departments
-- WHERE department_id = 40;


-- ============================================================
-- SECTION 10: ON DELETE CASCADE
-- ============================================================


-- ------------------------------------------------------------
-- 26. Delete an employee with project assignments
-- ------------------------------------------------------------

-- Employee 2 has an assignment to Project 101.
-- Deleting the employee also deletes that assignment.

SELECT *
FROM d29_assignments
WHERE employee_id = 2;


DELETE FROM d29_employees
WHERE employee_id = 2;


SELECT *
FROM d29_assignments
WHERE employee_id = 2;


-- ------------------------------------------------------------
-- 27. Delete a project with assignments
-- ------------------------------------------------------------

-- Project 104 has an assignment for Employee 1.
-- The assignment is removed automatically.

SELECT *
FROM d29_assignments
WHERE project_id = 104;


DELETE FROM d29_projects
WHERE project_id = 104;


SELECT *
FROM d29_assignments
WHERE project_id = 104;


-- ============================================================
-- SECTION 11: REMOVE A PREVIOUSLY RESTRICTED DEPARTMENT
-- ============================================================


-- ------------------------------------------------------------
-- 28. Delete department after removing its project
-- ------------------------------------------------------------

-- Department 40 no longer has dependent projects.

DELETE FROM d29_departments
WHERE department_id = 40;


SELECT *
FROM d29_departments
ORDER BY department_id;


-- ============================================================
-- SECTION 12: ON DELETE SET NULL
-- ============================================================


-- ------------------------------------------------------------
-- 29. Remove department while preserving its employee
-- ------------------------------------------------------------

-- Department 30 owns Project 103.
-- Remove that project first because of ON DELETE RESTRICT.

DELETE FROM d29_projects
WHERE project_id = 103;


-- This also removes assignments belonging to Project 103.

-- Now delete Department 30.

DELETE FROM d29_departments
WHERE department_id = 30;


-- Employee 4 remains, but department_id becomes NULL.

SELECT
    employee_id,
    full_name,
    department_id
FROM d29_employees
WHERE employee_id = 4;


-- ============================================================
-- SECTION 13: FINAL INTEGRITY INSPECTION
-- ============================================================


-- ------------------------------------------------------------
-- 30. Inspect all Day 29 constraints
-- ------------------------------------------------------------

SELECT
    table_name,
    constraint_name,
    constraint_type
FROM information_schema.table_constraints
WHERE table_schema = DATABASE()
  AND table_name IN (
      'd29_departments',
      'd29_employees',
      'd29_projects',
      'd29_assignments'
  )
ORDER BY
    table_name,
    constraint_type,
    constraint_name;


-- ------------------------------------------------------------
-- Inspect foreign key actions
-- ------------------------------------------------------------

SELECT
    table_name,
    constraint_name,
    update_rule,
    delete_rule
FROM information_schema.referential_constraints
WHERE constraint_schema = DATABASE()
  AND table_name IN (
      'd29_employees',
      'd29_projects',
      'd29_assignments'
  )
ORDER BY table_name, constraint_name;


-- ------------------------------------------------------------
-- Inspect CHECK constraints
-- ------------------------------------------------------------

SELECT
    constraint_name,
    check_clause
FROM information_schema.check_constraints
WHERE constraint_schema = DATABASE()
  AND constraint_name LIKE 'chk_d29_%'
ORDER BY constraint_name;


-- ------------------------------------------------------------
-- Verify no orphaned employee-department references
-- ------------------------------------------------------------

SELECT
    COUNT(*) AS orphaned_department_references
FROM d29_employees AS e
LEFT JOIN d29_departments AS d
    ON e.department_id = d.department_id
WHERE e.department_id IS NOT NULL
  AND d.department_id IS NULL;


-- ------------------------------------------------------------
-- Verify no orphaned project assignments
-- ------------------------------------------------------------

SELECT
    COUNT(*) AS orphaned_assignments
FROM d29_assignments AS a
LEFT JOIN d29_employees AS e
    ON a.employee_id = e.employee_id
LEFT JOIN d29_projects AS p
    ON a.project_id = p.project_id
WHERE e.employee_id IS NULL
   OR p.project_id IS NULL;


-- ------------------------------------------------------------
-- Final employee and department report
-- ------------------------------------------------------------

SELECT
    e.employee_id,
    e.full_name,
    e.email,
    COALESCE(
        d.department_name,
        'Unassigned'
    ) AS department,
    e.base_salary,
    e.bonus,
    e.employment_status
FROM d29_employees AS e
LEFT JOIN d29_departments AS d
    ON e.department_id = d.department_id
ORDER BY e.employee_id;


-- ------------------------------------------------------------
-- Final project assignment report
-- ------------------------------------------------------------

SELECT
    a.employee_id,
    e.full_name,
    a.project_id,
    p.project_code,
    a.hours_per_week
FROM d29_assignments AS a
JOIN d29_employees AS e
    ON a.employee_id = e.employee_id
JOIN d29_projects AS p
    ON a.project_id = p.project_id
ORDER BY a.employee_id, a.project_id;


-- ============================================================
-- END OF DAY 29
-- ============================================================

-- Key Takeaways:
--
-- 1. Constraints enforce database integrity.
-- 2. UNIQUE can apply to multiple columns.
-- 3. CHECK validates acceptable values.
-- 4. NOT NULL prevents missing values.
-- 5. Foreign keys protect table relationships.
-- 6. CASCADE propagates changes automatically.
-- 7. RESTRICT prevents unsafe parent deletions.
-- 8. SET NULL preserves optional child records.
-- 9. Named constraints simplify maintenance.
-- 10. INFORMATION_SCHEMA exposes constraint metadata.
--
-- All exercises use isolated Day 29 practice tables.
-- Existing challenge tables remain unchanged.