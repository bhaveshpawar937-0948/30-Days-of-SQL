-- ============================================================
-- 30 Days of SQL
-- Day 28: Triggers & Automated Database Actions
-- Author: Bhavesh Pawar
-- ============================================================

USE sql_30_days;


-- ------------------------------------------------------------
-- 1. Create salary audit table
-- ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS employee_salary_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    employee_name VARCHAR(100),
    old_salary DECIMAL(10,2),
    new_salary DECIMAL(10,2),
    changed_at TIMESTAMP
        DEFAULT CURRENT_TIMESTAMP
);


-- ------------------------------------------------------------
-- 2. Create employee activity log
-- ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS employee_activity_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    employee_name VARCHAR(100),
    action_type VARCHAR(20),
    action_time TIMESTAMP
        DEFAULT CURRENT_TIMESTAMP
);


-- ------------------------------------------------------------
-- 3. Remove previous salary trigger if it exists
-- ------------------------------------------------------------

DROP TRIGGER IF EXISTS
trg_employee_salary_update;


-- ------------------------------------------------------------
-- 4. Create salary update audit trigger
-- ------------------------------------------------------------

DELIMITER //

CREATE TRIGGER trg_employee_salary_update
AFTER UPDATE
ON employees
FOR EACH ROW

BEGIN

    IF NOT (OLD.salary <=> NEW.salary) THEN

        INSERT INTO employee_salary_audit (
            employee_id,
            employee_name,
            old_salary,
            new_salary
        )
        VALUES (
            NEW.employee_id,
            NEW.employee_name,
            OLD.salary,
            NEW.salary
        );

    END IF;

END //

DELIMITER ;


-- ------------------------------------------------------------
-- 5. Test salary audit trigger
-- ------------------------------------------------------------

START TRANSACTION;

UPDATE employees
SET salary = salary + 500
WHERE employee_id = 1;

SELECT *
FROM employee_salary_audit
ORDER BY audit_id DESC;

ROLLBACK;


-- ------------------------------------------------------------
-- 6. View salary audit history
-- ------------------------------------------------------------

SELECT *
FROM employee_salary_audit
ORDER BY changed_at DESC;


-- ------------------------------------------------------------
-- 7. Remove previous insert trigger
-- ------------------------------------------------------------

DROP TRIGGER IF EXISTS
trg_employee_insert_log;


-- ------------------------------------------------------------
-- 8. Create employee insert logging trigger
-- ------------------------------------------------------------

DELIMITER //

CREATE TRIGGER trg_employee_insert_log
AFTER INSERT
ON employees
FOR EACH ROW

BEGIN

    INSERT INTO employee_activity_log (
        employee_id,
        employee_name,
        action_type
    )
    VALUES (
        NEW.employee_id,
        NEW.employee_name,
        'INSERT'
    );

END //

DELIMITER ;


-- ------------------------------------------------------------
-- 9. Remove previous delete trigger
-- ------------------------------------------------------------

DROP TRIGGER IF EXISTS
trg_employee_delete_log;


-- ------------------------------------------------------------
-- 10. Create employee delete logging trigger
-- ------------------------------------------------------------

DELIMITER //

CREATE TRIGGER trg_employee_delete_log
AFTER DELETE
ON employees
FOR EACH ROW

BEGIN

    INSERT INTO employee_activity_log (
        employee_id,
        employee_name,
        action_type
    )
    VALUES (
        OLD.employee_id,
        OLD.employee_name,
        'DELETE'
    );

END //

DELIMITER ;


-- ------------------------------------------------------------
-- 11. Create separate table for safe trigger testing
-- ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS trigger_demo_employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_name VARCHAR(100),
    department VARCHAR(100),
    salary DECIMAL(10,2)
);


-- ------------------------------------------------------------
-- 12. Create demo activity log
-- ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS trigger_demo_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    employee_name VARCHAR(100),
    action_type VARCHAR(20),
    old_salary DECIMAL(10,2),
    new_salary DECIMAL(10,2),
    logged_at TIMESTAMP
        DEFAULT CURRENT_TIMESTAMP
);


-- ------------------------------------------------------------
-- 13. BEFORE INSERT data-cleaning trigger
-- ------------------------------------------------------------

DROP TRIGGER IF EXISTS
trg_demo_clean_employee;


DELIMITER //

CREATE TRIGGER trg_demo_clean_employee
BEFORE INSERT
ON trigger_demo_employees
FOR EACH ROW

BEGIN

    SET NEW.employee_name =
        TRIM(NEW.employee_name);

    SET NEW.department =
        TRIM(NEW.department);

END //

DELIMITER ;


-- ------------------------------------------------------------
-- 14. Test automatic data cleaning
-- ------------------------------------------------------------

INSERT INTO trigger_demo_employees (
    employee_name,
    department,
    salary
)
VALUES (
    '   Rahul   ',
    '   Engineering   ',
    65000
);


SELECT *
FROM trigger_demo_employees;


-- ------------------------------------------------------------
-- 15. BEFORE INSERT salary validation trigger
-- ------------------------------------------------------------

DROP TRIGGER IF EXISTS
trg_demo_validate_salary_insert;


DELIMITER //

CREATE TRIGGER trg_demo_validate_salary_insert
BEFORE INSERT
ON trigger_demo_employees
FOR EACH ROW

BEGIN

    IF NEW.salary < 0 THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
            'Salary cannot be negative';

    END IF;

END //

DELIMITER ;


-- ------------------------------------------------------------
-- 16. Valid insert
-- ------------------------------------------------------------

INSERT INTO trigger_demo_employees (
    employee_name,
    department,
    salary
)
VALUES (
    'Priya',
    'Analytics',
    70000
);


-- ------------------------------------------------------------
-- 17. Invalid insert example
-- Uncomment to test validation
-- ------------------------------------------------------------

-- INSERT INTO trigger_demo_employees (
--     employee_name,
--     department,
--     salary
-- )
-- VALUES (
--     'Invalid Employee',
--     'Testing',
--     -5000
-- );


-- ------------------------------------------------------------
-- 18. BEFORE UPDATE salary validation
-- ------------------------------------------------------------

DROP TRIGGER IF EXISTS
trg_demo_validate_salary_update;


DELIMITER //

CREATE TRIGGER trg_demo_validate_salary_update
BEFORE UPDATE
ON trigger_demo_employees
FOR EACH ROW

BEGIN

    IF NEW.salary < 0 THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
            'Updated salary cannot be negative';

    END IF;

END //

DELIMITER ;


-- ------------------------------------------------------------
-- 19. AFTER INSERT demo log
-- ------------------------------------------------------------

DROP TRIGGER IF EXISTS
trg_demo_insert_log;


DELIMITER //

CREATE TRIGGER trg_demo_insert_log
AFTER INSERT
ON trigger_demo_employees
FOR EACH ROW

BEGIN

    INSERT INTO trigger_demo_log (
        employee_id,
        employee_name,
        action_type,
        new_salary
    )
    VALUES (
        NEW.employee_id,
        NEW.employee_name,
        'INSERT',
        NEW.salary
    );

END //

DELIMITER ;


-- ------------------------------------------------------------
-- 20. AFTER UPDATE demo log
-- ------------------------------------------------------------

DROP TRIGGER IF EXISTS
trg_demo_update_log;


DELIMITER //

CREATE TRIGGER trg_demo_update_log
AFTER UPDATE
ON trigger_demo_employees
FOR EACH ROW

BEGIN

    INSERT INTO trigger_demo_log (
        employee_id,
        employee_name,
        action_type,
        old_salary,
        new_salary
    )
    VALUES (
        NEW.employee_id,
        NEW.employee_name,
        'UPDATE',
        OLD.salary,
        NEW.salary
    );

END //

DELIMITER ;


-- ------------------------------------------------------------
-- 21. AFTER DELETE demo log
-- ------------------------------------------------------------

DROP TRIGGER IF EXISTS
trg_demo_delete_log;


DELIMITER //

CREATE TRIGGER trg_demo_delete_log
AFTER DELETE
ON trigger_demo_employees
FOR EACH ROW

BEGIN

    INSERT INTO trigger_demo_log (
        employee_id,
        employee_name,
        action_type,
        old_salary
    )
    VALUES (
        OLD.employee_id,
        OLD.employee_name,
        'DELETE',
        OLD.salary
    );

END //

DELIMITER ;


-- ------------------------------------------------------------
-- 22. Insert employee and generate log automatically
-- ------------------------------------------------------------

INSERT INTO trigger_demo_employees (
    employee_name,
    department,
    salary
)
VALUES (
    'Aman',
    'Data Science',
    68000
);


-- ------------------------------------------------------------
-- 23. Update employee and generate log automatically
-- ------------------------------------------------------------

UPDATE trigger_demo_employees
SET salary = 72000
WHERE employee_name = 'Aman';


-- ------------------------------------------------------------
-- 24. Delete employee and generate log automatically
-- ------------------------------------------------------------

DELETE FROM trigger_demo_employees
WHERE employee_name = 'Aman';


-- ------------------------------------------------------------
-- 25. View complete trigger log
-- ------------------------------------------------------------

SELECT *
FROM trigger_demo_log
ORDER BY log_id;


-- ------------------------------------------------------------
-- 26. Create student score validation trigger
-- ------------------------------------------------------------

DROP TRIGGER IF EXISTS
trg_validate_student_score;


DELIMITER //

CREATE TRIGGER trg_validate_student_score
BEFORE UPDATE
ON student_scores
FOR EACH ROW

BEGIN

    IF NEW.score < 0
       OR NEW.score > 100 THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
            'Student score must be between 0 and 100';

    END IF;

END //

DELIMITER ;


-- ------------------------------------------------------------
-- 27. Safe valid score update test
-- ------------------------------------------------------------

START TRANSACTION;

UPDATE student_scores
SET score = 88
WHERE student_id = 1;

SELECT
    student_id,
    student_name,
    score
FROM student_scores
WHERE student_id = 1;

ROLLBACK;


-- ------------------------------------------------------------
-- 28. Invalid score example
-- Uncomment to test trigger validation
-- ------------------------------------------------------------

-- UPDATE student_scores
-- SET score = 150
-- WHERE student_id = 1;


-- ------------------------------------------------------------
-- 29. Inspect all triggers
-- ------------------------------------------------------------

SHOW TRIGGERS;


-- ------------------------------------------------------------
-- 30. Final trigger analytics
-- ------------------------------------------------------------

SELECT
    action_type,
    COUNT(*) AS total_events
FROM trigger_demo_log
GROUP BY action_type
ORDER BY total_events DESC;


SELECT
    employee_id,
    employee_name,
    old_salary,
    new_salary,
    changed_at
FROM employee_salary_audit
ORDER BY changed_at DESC;