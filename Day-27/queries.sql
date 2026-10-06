-- ============================================================
-- 30 Days of SQL
-- Day 27: Stored Functions & Custom SQL Functions
-- Author: Bhavesh Pawar
-- ============================================================

USE sql_30_days;


-- ------------------------------------------------------------
-- 1. Create a basic addition function
-- ------------------------------------------------------------

DROP FUNCTION IF EXISTS AddNumbers;

DELIMITER //

CREATE FUNCTION AddNumbers(
    number_one INT,
    number_two INT
)
RETURNS INT
DETERMINISTIC
NO SQL

BEGIN

    RETURN number_one + number_two;

END //

DELIMITER ;


-- ------------------------------------------------------------
-- 2. Test the addition function
-- ------------------------------------------------------------

SELECT
    AddNumbers(10, 20)
        AS total;


-- ------------------------------------------------------------
-- 3. Create a salary bonus function
-- ------------------------------------------------------------

DROP FUNCTION IF EXISTS CalculateBonus;

DELIMITER //

CREATE FUNCTION CalculateBonus(
    salary_amount DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
NO SQL

BEGIN

    IF salary_amount IS NULL THEN
        RETURN 0;
    END IF;

    RETURN salary_amount * 0.10;

END //

DELIMITER ;


-- ------------------------------------------------------------
-- 4. Test bonus calculation
-- ------------------------------------------------------------

SELECT
    CalculateBonus(50000)
        AS bonus_amount;


-- ------------------------------------------------------------
-- 5. Apply bonus function to employees
-- ------------------------------------------------------------

SELECT
    employee_name,
    salary,

    CalculateBonus(salary)
        AS bonus_amount

FROM employees

ORDER BY salary DESC;


-- ------------------------------------------------------------
-- 6. Calculate salary after bonus
-- ------------------------------------------------------------

SELECT
    employee_name,
    salary,

    CalculateBonus(salary)
        AS bonus_amount,

    salary + CalculateBonus(salary)
        AS salary_with_bonus

FROM employees;


-- ------------------------------------------------------------
-- 7. Create salary classification function
-- ------------------------------------------------------------

DROP FUNCTION IF EXISTS SalaryCategory;

DELIMITER //

CREATE FUNCTION SalaryCategory(
    employee_salary DECIMAL(10,2)
)
RETURNS VARCHAR(30)
DETERMINISTIC
NO SQL

BEGIN

    IF employee_salary IS NULL THEN

        RETURN 'Unknown';

    ELSEIF employee_salary >= 80000 THEN

        RETURN 'High Salary';

    ELSEIF employee_salary >= 60000 THEN

        RETURN 'Medium Salary';

    ELSE

        RETURN 'Entry Salary';

    END IF;

END //

DELIMITER ;


-- ------------------------------------------------------------
-- 8. Test salary classification
-- ------------------------------------------------------------

SELECT
    SalaryCategory(90000)
        AS category_one,

    SalaryCategory(70000)
        AS category_two,

    SalaryCategory(45000)
        AS category_three;


-- ------------------------------------------------------------
-- 9. Classify employee salaries
-- ------------------------------------------------------------

SELECT
    employee_name,
    department,
    salary,

    SalaryCategory(salary)
        AS salary_category

FROM employees

ORDER BY salary DESC;


-- ------------------------------------------------------------
-- 10. Count employees by custom salary category
-- ------------------------------------------------------------

SELECT
    SalaryCategory(salary)
        AS salary_category,

    COUNT(*) AS employee_count

FROM employees

GROUP BY SalaryCategory(salary)

ORDER BY employee_count DESC;


-- ------------------------------------------------------------
-- 11. Create student performance function
-- ------------------------------------------------------------

DROP FUNCTION IF EXISTS PerformanceCategory;

DELIMITER //

CREATE FUNCTION PerformanceCategory(
    student_score DECIMAL(5,2)
)
RETURNS VARCHAR(30)
DETERMINISTIC
NO SQL

BEGIN

    RETURN CASE

        WHEN student_score IS NULL
            THEN 'Unknown'

        WHEN student_score >= 90
            THEN 'Excellent'

        WHEN student_score >= 80
            THEN 'Very Good'

        WHEN student_score >= 70
            THEN 'Good'

        WHEN student_score >= 60
            THEN 'Average'

        ELSE 'Needs Improvement'

    END;

END //

DELIMITER ;


-- ------------------------------------------------------------
-- 12. Test student performance function
-- ------------------------------------------------------------

SELECT
    PerformanceCategory(94)
        AS performance;


-- ------------------------------------------------------------
-- 13. Apply performance function to students
-- ------------------------------------------------------------

SELECT
    student_name,
    department,
    score,

    PerformanceCategory(score)
        AS performance_category

FROM student_scores

ORDER BY score DESC;


-- ------------------------------------------------------------
-- 14. Count students by performance category
-- ------------------------------------------------------------

SELECT
    PerformanceCategory(score)
        AS performance_category,

    COUNT(*) AS student_count

FROM student_scores

GROUP BY PerformanceCategory(score)

ORDER BY student_count DESC;


-- ------------------------------------------------------------
-- 15. Create percentage calculator
-- ------------------------------------------------------------

DROP FUNCTION IF EXISTS CalculatePercentage;

DELIMITER //

CREATE FUNCTION CalculatePercentage(
    value_amount DECIMAL(10,2),
    percentage_value DECIMAL(5,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
NO SQL

BEGIN

    IF value_amount IS NULL
       OR percentage_value IS NULL THEN

        RETURN 0;

    END IF;

    RETURN
        value_amount *
        percentage_value / 100;

END //

DELIMITER ;


-- ------------------------------------------------------------
-- 16. Test percentage calculator
-- ------------------------------------------------------------

SELECT
    CalculatePercentage(
        50000,
        12
    ) AS twelve_percent;


-- ------------------------------------------------------------
-- 17. Calculate custom employee bonuses
-- ------------------------------------------------------------

SELECT
    employee_name,
    salary,

    CalculatePercentage(
        salary,
        15
    ) AS fifteen_percent_bonus

FROM employees;


-- ------------------------------------------------------------
-- 18. Create salary after increment function
-- ------------------------------------------------------------

DROP FUNCTION IF EXISTS SalaryAfterIncrement;

DELIMITER //

CREATE FUNCTION SalaryAfterIncrement(
    current_salary DECIMAL(10,2),
    increment_percentage DECIMAL(5,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
NO SQL

BEGIN

    DECLARE increment_amount
        DECIMAL(10,2);

    IF current_salary IS NULL THEN
        RETURN 0;
    END IF;

    SET increment_amount =
        current_salary *
        IFNULL(increment_percentage, 0)
        / 100;

    RETURN
        current_salary +
        increment_amount;

END //

DELIMITER ;


-- ------------------------------------------------------------
-- 19. Test salary increment function
-- ------------------------------------------------------------

SELECT
    SalaryAfterIncrement(
        60000,
        10
    ) AS new_salary;


-- ------------------------------------------------------------
-- 20. Apply salary increment to employees
-- ------------------------------------------------------------

SELECT
    employee_name,
    salary,

    SalaryAfterIncrement(
        salary,
        10
    ) AS projected_salary

FROM employees

ORDER BY salary DESC;


-- ------------------------------------------------------------
-- 21. Create formatted employee ID function
-- ------------------------------------------------------------

DROP FUNCTION IF EXISTS FormatEmployeeID;

DELIMITER //

CREATE FUNCTION FormatEmployeeID(
    employee_identifier INT
)
RETURNS VARCHAR(20)
DETERMINISTIC
NO SQL

BEGIN

    RETURN CONCAT(
        'EMP-',
        LPAD(
            employee_identifier,
            4,
            '0'
        )
    );

END //

DELIMITER ;


-- ------------------------------------------------------------
-- 22. Generate formatted employee IDs
-- ------------------------------------------------------------

SELECT
    employee_id,

    FormatEmployeeID(employee_id)
        AS formatted_employee_id,

    employee_name

FROM employees

ORDER BY employee_id;


-- ------------------------------------------------------------
-- 23. Create employee-name formatting function
-- ------------------------------------------------------------

DROP FUNCTION IF EXISTS FormatEmployeeName;

DELIMITER //

CREATE FUNCTION FormatEmployeeName(
    employee_name_value VARCHAR(100)
)
RETURNS VARCHAR(120)
DETERMINISTIC
NO SQL

BEGIN

    IF employee_name_value IS NULL THEN

        RETURN 'Employee: Unknown';

    END IF;

    RETURN CONCAT(
        'Employee: ',
        UPPER(
            TRIM(employee_name_value)
        )
    );

END //

DELIMITER ;


-- ------------------------------------------------------------
-- 24. Apply employee name formatting
-- ------------------------------------------------------------

SELECT
    employee_name,

    FormatEmployeeName(employee_name)
        AS formatted_name

FROM employees;


-- ------------------------------------------------------------
-- 25. Create annual salary function
-- ------------------------------------------------------------

DROP FUNCTION IF EXISTS AnnualSalary;

DELIMITER //

CREATE FUNCTION AnnualSalary(
    monthly_salary DECIMAL(10,2)
)
RETURNS DECIMAL(12,2)
DETERMINISTIC
NO SQL

BEGIN

    RETURN
        IFNULL(monthly_salary, 0)
        * 12;

END //

DELIMITER ;


-- ------------------------------------------------------------
-- 26. Calculate annual salaries
-- ------------------------------------------------------------

SELECT
    employee_name,
    salary AS monthly_salary,

    AnnualSalary(salary)
        AS annual_salary

FROM employees

ORDER BY annual_salary DESC;


-- ------------------------------------------------------------
-- 27. Create score difference function
-- ------------------------------------------------------------

DROP FUNCTION IF EXISTS ScoreDifference;

DELIMITER //

CREATE FUNCTION ScoreDifference(
    actual_score DECIMAL(5,2),
    target_score DECIMAL(5,2)
)
RETURNS DECIMAL(6,2)
DETERMINISTIC
NO SQL

BEGIN

    RETURN
        IFNULL(actual_score, 0)
        -
        IFNULL(target_score, 0);

END //

DELIMITER ;


-- ------------------------------------------------------------
-- 28. Compare student scores against target
-- ------------------------------------------------------------

SELECT
    student_name,
    score,

    ScoreDifference(
        score,
        80
    ) AS difference_from_target,

    CASE
        WHEN ScoreDifference(score, 80) >= 0
            THEN 'Target Achieved'

        ELSE 'Below Target'
    END AS target_status

FROM student_scores

ORDER BY score DESC;


-- ------------------------------------------------------------
-- 29. Use multiple custom functions together
-- ------------------------------------------------------------

SELECT
    FormatEmployeeID(employee_id)
        AS employee_code,

    FormatEmployeeName(employee_name)
        AS employee_name,

    salary,

    SalaryCategory(salary)
        AS salary_category,

    CalculateBonus(salary)
        AS standard_bonus,

    AnnualSalary(salary)
        AS annual_salary

FROM employees

ORDER BY salary DESC;


-- ------------------------------------------------------------
-- 30. Final custom-function analytics report
-- ------------------------------------------------------------

SELECT
    FormatEmployeeID(employee_id)
        AS employee_code,

    employee_name,
    department,
    job_role,

    salary AS current_salary,

    SalaryCategory(salary)
        AS salary_category,

    CalculatePercentage(
        salary,
        10
    ) AS ten_percent_bonus,

    SalaryAfterIncrement(
        salary,
        10
    ) AS projected_monthly_salary,

    AnnualSalary(
        SalaryAfterIncrement(
            salary,
            10
        )
    ) AS projected_annual_salary

FROM employees

ORDER BY projected_annual_salary DESC;