-- ============================================================
-- 30 Days of SQL
-- Day 16: String Functions & Text Manipulation
-- Author: Bhavesh Pawar
-- ============================================================

USE sql_30_days;


-- ------------------------------------------------------------
-- 1. Convert employee names to uppercase
-- ------------------------------------------------------------

SELECT
    employee_name,
    UPPER(employee_name) AS uppercase_name
FROM employees;


-- ------------------------------------------------------------
-- 2. Convert employee names to lowercase
-- ------------------------------------------------------------

SELECT
    employee_name,
    LOWER(employee_name) AS lowercase_name
FROM employees;


-- ------------------------------------------------------------
-- 3. Convert departments to uppercase
-- ------------------------------------------------------------

SELECT
    department,
    UPPER(department) AS standardized_department
FROM employees;


-- ------------------------------------------------------------
-- 4. Measure employee-name length
-- ------------------------------------------------------------

SELECT
    employee_name,
    CHAR_LENGTH(employee_name) AS name_length
FROM employees;


-- ------------------------------------------------------------
-- 5. Compare LENGTH and CHAR_LENGTH
-- ------------------------------------------------------------

SELECT
    employee_name,
    LENGTH(employee_name) AS byte_length,
    CHAR_LENGTH(employee_name) AS character_length
FROM employees;


-- ------------------------------------------------------------
-- 6. Combine employee name and job role
-- ------------------------------------------------------------

SELECT
    CONCAT(
        employee_name,
        ' - ',
        job_role
    ) AS employee_details
FROM employees;


-- ------------------------------------------------------------
-- 7. Combine multiple columns using CONCAT_WS
-- ------------------------------------------------------------

SELECT
    CONCAT_WS(
        ' | ',
        employee_name,
        department,
        job_role
    ) AS employee_summary
FROM employees;


-- ------------------------------------------------------------
-- 8. Create a readable salary label
-- ------------------------------------------------------------

SELECT
    CONCAT(
        employee_name,
        ' earns ',
        salary
    ) AS salary_summary
FROM employees;


-- ------------------------------------------------------------
-- 9. Demonstrate TRIM
-- ------------------------------------------------------------

SELECT
    '   Data Analyst   ' AS original_text,
    TRIM('   Data Analyst   ') AS cleaned_text;


-- ------------------------------------------------------------
-- 10. Demonstrate LTRIM
-- ------------------------------------------------------------

SELECT
    LTRIM('     SQL Developer') AS left_trimmed;


-- ------------------------------------------------------------
-- 11. Demonstrate RTRIM
-- ------------------------------------------------------------

SELECT
    RTRIM('SQL Developer     ') AS right_trimmed;


-- ------------------------------------------------------------
-- 12. Clean and standardize employee names
-- ------------------------------------------------------------

SELECT
    employee_name,
    UPPER(TRIM(employee_name))
        AS standardized_name
FROM employees;


-- ------------------------------------------------------------
-- 13. Extract first three characters of department
-- ------------------------------------------------------------

SELECT
    department,
    LEFT(department, 3)
        AS department_prefix
FROM employees;


-- ------------------------------------------------------------
-- 14. Extract last four characters of employee names
-- ------------------------------------------------------------

SELECT
    employee_name,
    RIGHT(employee_name, 4)
        AS name_suffix
FROM employees;


-- ------------------------------------------------------------
-- 15. Extract part of a string with SUBSTRING
-- ------------------------------------------------------------

SELECT
    SUBSTRING(
        'Data Engineering',
        6,
        11
    ) AS extracted_text;


-- ------------------------------------------------------------
-- 16. Extract the first five characters of student names
-- ------------------------------------------------------------

SELECT
    name,
    SUBSTRING(name, 1, 5)
        AS short_name
FROM students;


-- ------------------------------------------------------------
-- 17. Replace text inside a string
-- ------------------------------------------------------------

SELECT
    REPLACE(
        'Junior Data Analyst',
        'Junior',
        'Senior'
    ) AS modified_role;


-- ------------------------------------------------------------
-- 18. Standardize a department label using REPLACE
-- ------------------------------------------------------------

SELECT
    department,
    REPLACE(
        department,
        'Data Science',
        'DS'
    ) AS short_department
FROM students;


-- ------------------------------------------------------------
-- 19. Find position of text using LOCATE
-- ------------------------------------------------------------

SELECT
    LOCATE(
        'Data',
        'Senior Data Analyst'
    ) AS data_position;


-- ------------------------------------------------------------
-- 20. Search job roles for the word Data
-- ------------------------------------------------------------

SELECT
    employee_name,
    job_role,
    LOCATE('Data', job_role)
        AS data_position
FROM employees;


-- ------------------------------------------------------------
-- 21. Use INSTR to find text position
-- ------------------------------------------------------------

SELECT
    employee_name,
    department,
    INSTR(department, 'Data')
        AS data_position
FROM employees;


-- ------------------------------------------------------------
-- 22. Reverse employee names
-- ------------------------------------------------------------

SELECT
    employee_name,
    REVERSE(employee_name)
        AS reversed_name
FROM employees;


-- ------------------------------------------------------------
-- 23. Create zero-padded employee IDs
-- ------------------------------------------------------------

SELECT
    employee_id,
    LPAD(employee_id, 5, '0')
        AS formatted_employee_id
FROM employees;


-- ------------------------------------------------------------
-- 24. Create zero-padded student IDs
-- ------------------------------------------------------------

SELECT
    student_id,
    LPAD(student_id, 5, '0')
        AS formatted_student_id
FROM students;


-- ------------------------------------------------------------
-- 25. Demonstrate RPAD
-- ------------------------------------------------------------

SELECT
    employee_name,
    RPAD(employee_name, 25, '.')
        AS padded_name
FROM employees;


-- ------------------------------------------------------------
-- 26. Generate employee codes
-- ------------------------------------------------------------

SELECT
    employee_id,
    employee_name,
    department,

    CONCAT(
        UPPER(
            LEFT(
                COALESCE(department, 'UNK'),
                3
            )
        ),
        '-',
        LPAD(employee_id, 4, '0')
    ) AS employee_code

FROM employees;


-- ------------------------------------------------------------
-- 27. Generate student codes
-- ------------------------------------------------------------

SELECT
    student_id,
    name,
    department,

    CONCAT(
        UPPER(
            LEFT(
                COALESCE(department, 'UNK'),
                3
            )
        ),
        '-STU-',
        LPAD(student_id, 4, '0')
    ) AS student_code

FROM students;


-- ------------------------------------------------------------
-- 28. Find employees with long names
-- ------------------------------------------------------------

SELECT
    employee_name,
    CHAR_LENGTH(employee_name)
        AS name_length
FROM employees
WHERE CHAR_LENGTH(employee_name) > 10
ORDER BY name_length DESC;


-- ------------------------------------------------------------
-- 29. Build a formatted employee report
-- ------------------------------------------------------------

SELECT
    LPAD(employee_id, 4, '0')
        AS employee_id,

    UPPER(TRIM(employee_name))
        AS employee_name,

    UPPER(TRIM(
        COALESCE(department, 'Unknown')
    )) AS department,

    CONCAT(
        UPPER(LEFT(
            COALESCE(department, 'UNK'),
            3
        )),
        '-',
        LPAD(employee_id, 4, '0')
    ) AS employee_code,

    CONCAT(
        TRIM(employee_name),
        ' | ',
        COALESCE(job_role, 'Role Not Available')
    ) AS employee_label

FROM employees
ORDER BY employee_id;


-- ------------------------------------------------------------
-- 30. Final text data-quality report
-- ------------------------------------------------------------

SELECT
    COUNT(*) AS total_employees,

    SUM(
        CASE
            WHEN employee_name IS NULL
                 OR TRIM(employee_name) = ''
            THEN 1
            ELSE 0
        END
    ) AS missing_or_empty_names,

    SUM(
        CASE
            WHEN department IS NULL
                 OR TRIM(department) = ''
            THEN 1
            ELSE 0
        END
    ) AS missing_or_empty_departments,

    SUM(
        CASE
            WHEN job_role IS NULL
                 OR TRIM(job_role) = ''
            THEN 1
            ELSE 0
        END
    ) AS missing_or_empty_roles,

    ROUND(
        AVG(
            CHAR_LENGTH(
                TRIM(employee_name)
            )
        ),
        2
    ) AS average_name_length

FROM employees;