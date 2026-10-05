-- ============================================================
-- 30 Days of SQL
-- Day 26: Stored Procedures & Parameters
-- Author: Bhavesh Pawar
-- ============================================================

USE sql_30_days;


-- ------------------------------------------------------------
-- 1. Create a basic employee procedure
-- ------------------------------------------------------------

DROP PROCEDURE IF EXISTS GetAllEmployees;

DELIMITER //

CREATE PROCEDURE GetAllEmployees()
BEGIN

    SELECT
        employee_id,
        employee_name,
        department,
        job_role,
        salary
    FROM employees
    ORDER BY employee_id;

END //

DELIMITER ;


-- ------------------------------------------------------------
-- 2. Execute the procedure
-- ------------------------------------------------------------

CALL GetAllEmployees();


-- ------------------------------------------------------------
-- 3. Procedure with an IN parameter
-- ------------------------------------------------------------

DROP PROCEDURE IF EXISTS GetEmployeesByDepartment;

DELIMITER //

CREATE PROCEDURE GetEmployeesByDepartment(
    IN dept_name VARCHAR(100)
)
BEGIN

    SELECT
        employee_id,
        employee_name,
        department,
        salary
    FROM employees
    WHERE department = dept_name
    ORDER BY salary DESC;

END //

DELIMITER ;


-- ------------------------------------------------------------
-- 4. Call procedure with Engineering
-- ------------------------------------------------------------

CALL GetEmployeesByDepartment('Engineering');


-- ------------------------------------------------------------
-- 5. Call the same procedure with another department
-- ------------------------------------------------------------

CALL GetEmployeesByDepartment('Sales');


-- ------------------------------------------------------------
-- 6. Procedure with minimum salary parameter
-- ------------------------------------------------------------

DROP PROCEDURE IF EXISTS GetEmployeesAboveSalary;

DELIMITER //

CREATE PROCEDURE GetEmployeesAboveSalary(
    IN minimum_salary DECIMAL(10,2)
)
BEGIN

    SELECT
        employee_id,
        employee_name,
        department,
        salary
    FROM employees
    WHERE salary >= minimum_salary
    ORDER BY salary DESC;

END //

DELIMITER ;


-- ------------------------------------------------------------
-- 7. Execute salary filter procedure
-- ------------------------------------------------------------

CALL GetEmployeesAboveSalary(70000);


-- ------------------------------------------------------------
-- 8. Procedure with two parameters
-- ------------------------------------------------------------

DROP PROCEDURE IF EXISTS GetEmployeesBySalaryRange;

DELIMITER //

CREATE PROCEDURE GetEmployeesBySalaryRange(
    IN minimum_salary DECIMAL(10,2),
    IN maximum_salary DECIMAL(10,2)
)
BEGIN

    SELECT
        employee_name,
        department,
        salary
    FROM employees
    WHERE salary BETWEEN minimum_salary
                     AND maximum_salary
    ORDER BY salary;

END //

DELIMITER ;


-- ------------------------------------------------------------
-- 9. Execute salary range procedure
-- ------------------------------------------------------------

CALL GetEmployeesBySalaryRange(
    50000,
    80000
);


-- ------------------------------------------------------------
-- 10. Department and salary parameters together
-- ------------------------------------------------------------

DROP PROCEDURE IF EXISTS FindDepartmentEmployees;

DELIMITER //

CREATE PROCEDURE FindDepartmentEmployees(
    IN dept_name VARCHAR(100),
    IN minimum_salary DECIMAL(10,2)
)
BEGIN

    SELECT
        employee_name,
        department,
        salary
    FROM employees
    WHERE department = dept_name
      AND salary >= minimum_salary
    ORDER BY salary DESC;

END //

DELIMITER ;


-- ------------------------------------------------------------
-- 11. Execute department + salary procedure
-- ------------------------------------------------------------

CALL FindDepartmentEmployees(
    'Engineering',
    60000
);


-- ------------------------------------------------------------
-- 12. OUT parameter: employee count
-- ------------------------------------------------------------

DROP PROCEDURE IF EXISTS GetEmployeeCount;

DELIMITER //

CREATE PROCEDURE GetEmployeeCount(
    OUT total_employees INT
)
BEGIN

    SELECT COUNT(*)
    INTO total_employees
    FROM employees;

END //

DELIMITER ;


-- ------------------------------------------------------------
-- 13. Execute OUT parameter procedure
-- ------------------------------------------------------------

CALL GetEmployeeCount(@employee_total);

SELECT
    @employee_total AS total_employees;


-- ------------------------------------------------------------
-- 14. OUT parameter with department input
-- ------------------------------------------------------------

DROP PROCEDURE IF EXISTS GetDepartmentEmployeeCount;

DELIMITER //

CREATE PROCEDURE GetDepartmentEmployeeCount(
    IN dept_name VARCHAR(100),
    OUT employee_total INT
)
BEGIN

    SELECT COUNT(*)
    INTO employee_total
    FROM employees
    WHERE department = dept_name;

END //

DELIMITER ;


-- ------------------------------------------------------------
-- 15. Execute department count procedure
-- ------------------------------------------------------------

CALL GetDepartmentEmployeeCount(
    'Engineering',
    @engineering_total
);

SELECT
    @engineering_total
        AS engineering_employees;


-- ------------------------------------------------------------
-- 16. OUT parameter for average salary
-- ------------------------------------------------------------

DROP PROCEDURE IF EXISTS GetAverageSalary;

DELIMITER //

CREATE PROCEDURE GetAverageSalary(
    OUT average_salary DECIMAL(10,2)
)
BEGIN

    SELECT AVG(salary)
    INTO average_salary
    FROM employees;

END //

DELIMITER ;


-- ------------------------------------------------------------
-- 17. Execute average salary procedure
-- ------------------------------------------------------------

CALL GetAverageSalary(@avg_salary);

SELECT
    @avg_salary AS average_salary;


-- ------------------------------------------------------------
-- 18. INOUT parameter example
-- ------------------------------------------------------------

DROP PROCEDURE IF EXISTS AddSalaryBonus;

DELIMITER //

CREATE PROCEDURE AddSalaryBonus(
    INOUT salary_amount DECIMAL(10,2)
)
BEGIN

    SET salary_amount =
        salary_amount + 1000;

END //

DELIMITER ;


-- ------------------------------------------------------------
-- 19. Execute INOUT procedure
-- ------------------------------------------------------------

SET @salary_value = 50000;

CALL AddSalaryBonus(@salary_value);

SELECT
    @salary_value AS salary_after_bonus;


-- ------------------------------------------------------------
-- 20. Local variable example
-- ------------------------------------------------------------

DROP PROCEDURE IF EXISTS ShowEmployeeStatistics;

DELIMITER //

CREATE PROCEDURE ShowEmployeeStatistics()
BEGIN

    DECLARE total_employees INT;
    DECLARE average_salary DECIMAL(10,2);

    SELECT
        COUNT(*),
        AVG(salary)
    INTO
        total_employees,
        average_salary
    FROM employees;

    SELECT
        total_employees
            AS employee_count,
        average_salary
            AS average_salary;

END //

DELIMITER ;


-- ------------------------------------------------------------
-- 21. Execute statistics procedure
-- ------------------------------------------------------------

CALL ShowEmployeeStatistics();


-- ------------------------------------------------------------
-- 22. Department salary report
-- ------------------------------------------------------------

DROP PROCEDURE IF EXISTS DepartmentSalaryReport;

DELIMITER //

CREATE PROCEDURE DepartmentSalaryReport(
    IN dept_name VARCHAR(100)
)
BEGIN

    SELECT
        department,
        COUNT(*) AS employee_count,
        ROUND(AVG(salary), 2)
            AS average_salary,
        MIN(salary)
            AS minimum_salary,
        MAX(salary)
            AS maximum_salary,
        SUM(salary)
            AS total_payroll
    FROM employees
    WHERE department = dept_name
    GROUP BY department;

END //

DELIMITER ;


-- ------------------------------------------------------------
-- 23. Execute department report
-- ------------------------------------------------------------

CALL DepartmentSalaryReport(
    'Engineering'
);


-- ------------------------------------------------------------
-- 24. Student score filtering procedure
-- ------------------------------------------------------------

DROP PROCEDURE IF EXISTS GetStudentsAboveScore;

DELIMITER //

CREATE PROCEDURE GetStudentsAboveScore(
    IN minimum_score DECIMAL(5,2)
)
BEGIN

    SELECT
        student_id,
        student_name,
        department,
        score
    FROM student_scores
    WHERE score >= minimum_score
    ORDER BY score DESC;

END //

DELIMITER ;


-- ------------------------------------------------------------
-- 25. Execute student procedure
-- ------------------------------------------------------------

CALL GetStudentsAboveScore(80);


-- ------------------------------------------------------------
-- 26. Student department report procedure
-- ------------------------------------------------------------

DROP PROCEDURE IF EXISTS StudentDepartmentReport;

DELIMITER //

CREATE PROCEDURE StudentDepartmentReport(
    IN dept_name VARCHAR(100)
)
BEGIN

    SELECT
        department,
        COUNT(*) AS student_count,
        ROUND(AVG(score), 2)
            AS average_score,
        MIN(score)
            AS minimum_score,
        MAX(score)
            AS maximum_score
    FROM student_scores
    WHERE department = dept_name
    GROUP BY department;

END //

DELIMITER ;


-- ------------------------------------------------------------
-- 27. Salary classification procedure
-- ------------------------------------------------------------

DROP PROCEDURE IF EXISTS ClassifySalary;

DELIMITER //

CREATE PROCEDURE ClassifySalary(
    IN employee_salary DECIMAL(10,2)
)
BEGIN

    IF employee_salary >= 80000 THEN

        SELECT
            employee_salary AS salary,
            'High Salary' AS category;

    ELSEIF employee_salary >= 60000 THEN

        SELECT
            employee_salary AS salary,
            'Medium Salary' AS category;

    ELSE

        SELECT
            employee_salary AS salary,
            'Entry Salary' AS category;

    END IF;

END //

DELIMITER ;


-- ------------------------------------------------------------
-- 28. Test salary classification
-- ------------------------------------------------------------

CALL ClassifySalary(85000);

CALL ClassifySalary(70000);

CALL ClassifySalary(45000);


-- ------------------------------------------------------------
-- 29. Employee salary lookup using OUT parameters
-- ------------------------------------------------------------

DROP PROCEDURE IF EXISTS GetEmployeeSalary;

DELIMITER //

CREATE PROCEDURE GetEmployeeSalary(
    IN target_employee_id INT,
    OUT target_employee_name VARCHAR(100),
    OUT target_salary DECIMAL(10,2)
)
BEGIN

    SELECT
        employee_name,
        salary
    INTO
        target_employee_name,
        target_salary
    FROM employees
    WHERE employee_id = target_employee_id;

END //

DELIMITER ;


CALL GetEmployeeSalary(
    1,
    @employee_name,
    @employee_salary
);

SELECT
    @employee_name AS employee_name,
    @employee_salary AS salary;


-- ------------------------------------------------------------
-- 30. Final reusable analytical procedure
-- ------------------------------------------------------------

DROP PROCEDURE IF EXISTS EmployeeAnalyticsReport;

DELIMITER //

CREATE PROCEDURE EmployeeAnalyticsReport(
    IN dept_name VARCHAR(100),
    IN minimum_salary DECIMAL(10,2)
)
BEGIN

    DECLARE matching_employees INT;
    DECLARE matching_average_salary DECIMAL(10,2);

    SELECT
        COUNT(*),
        AVG(salary)
    INTO
        matching_employees,
        matching_average_salary
    FROM employees
    WHERE department = dept_name
      AND salary >= minimum_salary;

    SELECT
        dept_name AS department,
        minimum_salary
            AS minimum_salary_filter,
        matching_employees
            AS matching_employees,
        ROUND(
            matching_average_salary,
            2
        ) AS average_matching_salary;

    SELECT
        employee_id,
        employee_name,
        job_role,
        salary
    FROM employees
    WHERE department = dept_name
      AND salary >= minimum_salary
    ORDER BY salary DESC;

END //

DELIMITER ;


-- Execute final procedure

CALL EmployeeAnalyticsReport(
    'Engineering',
    60000
);