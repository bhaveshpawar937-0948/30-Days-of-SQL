-- ============================================================
-- 30 Days of SQL
-- Day 17: Date & Time Functions
-- Author: Bhavesh Pawar
-- ============================================================

USE sql_30_days;


-- ------------------------------------------------------------
-- 1. Display the current date
-- ------------------------------------------------------------

SELECT
    CURDATE() AS current_date;


-- ------------------------------------------------------------
-- 2. Display CURRENT_DATE
-- ------------------------------------------------------------

SELECT
    CURRENT_DATE() AS today;


-- ------------------------------------------------------------
-- 3. Display the current date and time
-- ------------------------------------------------------------

SELECT
    NOW() AS current_datetime;


-- ------------------------------------------------------------
-- 4. Display the current timestamp
-- ------------------------------------------------------------

SELECT
    CURRENT_TIMESTAMP() AS current_timestamp_value;


-- ------------------------------------------------------------
-- 5. Extract date and time separately
-- ------------------------------------------------------------

SELECT
    NOW() AS full_datetime,
    DATE(NOW()) AS date_only,
    TIME(NOW()) AS time_only;


-- ------------------------------------------------------------
-- 6. Extract year, month and day
-- ------------------------------------------------------------

SELECT
    CURDATE() AS full_date,
    YEAR(CURDATE()) AS current_year,
    MONTH(CURDATE()) AS current_month,
    DAY(CURDATE()) AS current_day;


-- ------------------------------------------------------------
-- 7. Display current month name
-- ------------------------------------------------------------

SELECT
    MONTHNAME(CURDATE()) AS current_month;


-- ------------------------------------------------------------
-- 8. Display current weekday name
-- ------------------------------------------------------------

SELECT
    DAYNAME(CURDATE()) AS current_weekday;


-- ------------------------------------------------------------
-- 9. Find numeric weekday
-- ------------------------------------------------------------

SELECT
    DAYOFWEEK(CURDATE()) AS weekday_number;


-- ------------------------------------------------------------
-- 10. Find position within the year
-- ------------------------------------------------------------

SELECT
    DAYOFYEAR(CURDATE()) AS day_of_year;


-- ------------------------------------------------------------
-- 11. Find current week number
-- ------------------------------------------------------------

SELECT
    WEEK(CURDATE()) AS current_week;


-- ------------------------------------------------------------
-- 12. Find current quarter
-- ------------------------------------------------------------

SELECT
    QUARTER(CURDATE()) AS current_quarter;


-- ------------------------------------------------------------
-- 13. Calculate difference between two dates
-- ------------------------------------------------------------

SELECT
    DATEDIFF(
        '2026-09-24',
        '2026-09-01'
    ) AS days_difference;


-- ------------------------------------------------------------
-- 14. Calculate days since the beginning of the year
-- ------------------------------------------------------------

SELECT
    DATEDIFF(
        CURDATE(),
        CONCAT(YEAR(CURDATE()), '-01-01')
    ) AS days_since_year_start;


-- ------------------------------------------------------------
-- 15. Calculate years between two dates
-- ------------------------------------------------------------

SELECT
    TIMESTAMPDIFF(
        YEAR,
        '2020-01-01',
        CURDATE()
    ) AS years_difference;


-- ------------------------------------------------------------
-- 16. Calculate months between two dates
-- ------------------------------------------------------------

SELECT
    TIMESTAMPDIFF(
        MONTH,
        '2025-01-01',
        CURDATE()
    ) AS months_difference;


-- ------------------------------------------------------------
-- 17. Calculate days using TIMESTAMPDIFF
-- ------------------------------------------------------------

SELECT
    TIMESTAMPDIFF(
        DAY,
        '2026-09-01',
        CURDATE()
    ) AS days_difference;


-- ------------------------------------------------------------
-- 18. Add seven days to the current date
-- ------------------------------------------------------------

SELECT
    CURDATE() AS today,
    DATE_ADD(
        CURDATE(),
        INTERVAL 7 DAY
    ) AS seven_days_later;


-- ------------------------------------------------------------
-- 19. Add one month
-- ------------------------------------------------------------

SELECT
    DATE_ADD(
        CURDATE(),
        INTERVAL 1 MONTH
    ) AS one_month_later;


-- ------------------------------------------------------------
-- 20. Add one year
-- ------------------------------------------------------------

SELECT
    DATE_ADD(
        CURDATE(),
        INTERVAL 1 YEAR
    ) AS one_year_later;


-- ------------------------------------------------------------
-- 21. Subtract seven days
-- ------------------------------------------------------------

SELECT
    DATE_SUB(
        CURDATE(),
        INTERVAL 7 DAY
    ) AS seven_days_ago;


-- ------------------------------------------------------------
-- 22. Subtract thirty days
-- ------------------------------------------------------------

SELECT
    DATE_SUB(
        CURDATE(),
        INTERVAL 30 DAY
    ) AS thirty_days_ago;


-- ------------------------------------------------------------
-- 23. Find the final day of the current month
-- ------------------------------------------------------------

SELECT
    LAST_DAY(CURDATE()) AS month_end;


-- ------------------------------------------------------------
-- 24. Calculate days remaining in the current month
-- ------------------------------------------------------------

SELECT
    DATEDIFF(
        LAST_DAY(CURDATE()),
        CURDATE()
    ) AS days_remaining_in_month;


-- ------------------------------------------------------------
-- 25. Format date as DD-MM-YYYY
-- ------------------------------------------------------------

SELECT
    DATE_FORMAT(
        CURDATE(),
        '%d-%m-%Y'
    ) AS formatted_date;


-- ------------------------------------------------------------
-- 26. Format date using month name
-- ------------------------------------------------------------

SELECT
    DATE_FORMAT(
        CURDATE(),
        '%d %M %Y'
    ) AS readable_date;


-- ------------------------------------------------------------
-- 27. Display detailed current date information
-- ------------------------------------------------------------

SELECT
    CURDATE() AS date,

    DAYNAME(CURDATE())
        AS weekday,

    DAY(CURDATE())
        AS day,

    MONTHNAME(CURDATE())
        AS month,

    YEAR(CURDATE())
        AS year,

    WEEK(CURDATE())
        AS week_number,

    QUARTER(CURDATE())
        AS quarter;


-- ------------------------------------------------------------
-- 28. Generate a rolling reporting window
-- ------------------------------------------------------------

SELECT
    CURDATE()
        AS report_date,

    DATE_SUB(
        CURDATE(),
        INTERVAL 7 DAY
    ) AS seven_day_start,

    DATE_SUB(
        CURDATE(),
        INTERVAL 30 DAY
    ) AS thirty_day_start,

    DATE_SUB(
        CURDATE(),
        INTERVAL 90 DAY
    ) AS ninety_day_start;


-- ------------------------------------------------------------
-- 29. Generate subscription-style expiration dates
-- ------------------------------------------------------------

SELECT
    CURDATE() AS start_date,

    DATE_ADD(
        CURDATE(),
        INTERVAL 1 MONTH
    ) AS one_month_expiry,

    DATE_ADD(
        CURDATE(),
        INTERVAL 3 MONTH
    ) AS three_month_expiry,

    DATE_ADD(
        CURDATE(),
        INTERVAL 1 YEAR
    ) AS annual_expiry;


-- ------------------------------------------------------------
-- 30. Final calendar analytics report
-- ------------------------------------------------------------

SELECT
    CURDATE() AS report_date,

    DATE_FORMAT(
        CURDATE(),
        '%d %M %Y'
    ) AS formatted_report_date,

    DAYNAME(CURDATE())
        AS weekday,

    MONTHNAME(CURDATE())
        AS month,

    YEAR(CURDATE())
        AS year,

    WEEK(CURDATE())
        AS week_number,

    QUARTER(CURDATE())
        AS quarter,

    DAYOFYEAR(CURDATE())
        AS day_of_year,

    LAST_DAY(CURDATE())
        AS month_end,

    DATEDIFF(
        LAST_DAY(CURDATE()),
        CURDATE()
    ) AS days_until_month_end,

    DATE_SUB(
        CURDATE(),
        INTERVAL 30 DAY
    ) AS rolling_30_day_start,

    DATE_ADD(
        CURDATE(),
        INTERVAL 30 DAY
    ) AS thirty_days_from_today;