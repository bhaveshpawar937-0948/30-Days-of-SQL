\# Day 17 - Date \& Time Functions 📅⏱️



Welcome to \*\*Day 17 of my 30 Days of SQL Challenge\*\*.



Today I explored \*\*SQL Date \& Time Functions\*\*, which allow us to work with dates, timestamps, durations, and time-based calculations directly inside SQL.



Date analysis is extremely important in real-world datasets. Businesses frequently need to answer questions such as:



\- How long has a customer been active?

\- How many days have passed since an order?

\- Which month generated the most activity?

\- What day of the week did an event occur?

\- Which records belong to the current year?

\- When does a subscription expire?



SQL provides built-in functions that make these calculations much easier.



\---



\## 📚 Concepts Covered



\- `CURDATE()`

\- `CURRENT\_DATE()`

\- `NOW()`

\- `CURRENT\_TIMESTAMP()`

\- `YEAR()`

\- `MONTH()`

\- `DAY()`

\- `MONTHNAME()`

\- `DAYNAME()`

\- `DAYOFWEEK()`

\- `DAYOFYEAR()`

\- `WEEK()`

\- `QUARTER()`

\- `DATE()`

\- `TIME()`

\- `DATEDIFF()`

\- `TIMESTAMPDIFF()`

\- `DATE\_ADD()`

\- `DATE\_SUB()`

\- `INTERVAL`

\- `LAST\_DAY()`

\- `DATE\_FORMAT()`

\- Time-based filtering

\- Duration calculations

\- Date-based reporting



\---



\# 📆 CURDATE()



`CURDATE()` returns the current date.



```sql

SELECT CURDATE();

```



Example:



```text

2026-09-24

```



It returns only the date portion.



\---



\# 🗓️ CURRENT\_DATE()



`CURRENT\_DATE()` provides the current date as well.



```sql

SELECT CURRENT\_DATE();

```



It is commonly used when comparing stored dates against today's date.



\---



\# 🕒 NOW()



`NOW()` returns both the current date and current time.



```sql

SELECT NOW();

```



Example:



```text

2026-09-24 19:30:00

```



\---



\# ⏱️ CURRENT\_TIMESTAMP()



`CURRENT\_TIMESTAMP()` also returns the current date and time.



```sql

SELECT CURRENT\_TIMESTAMP();

```



It is frequently used when storing creation or modification timestamps.



\---



\# 🧩 Extracting Date Components



Individual parts of a date can be extracted using functions such as:



```sql

YEAR(date)

MONTH(date)

DAY(date)

```



Example:



```sql

SELECT

&#x20;   order\_date,

&#x20;   YEAR(order\_date) AS order\_year,

&#x20;   MONTH(order\_date) AS order\_month,

&#x20;   DAY(order\_date) AS order\_day

FROM orders;

```



This is useful when grouping or filtering records by calendar periods.



\---



\# 🗓️ MONTHNAME()



`MONTHNAME()` returns the name of the month.



```sql

SELECT MONTHNAME('2026-09-24');

```



Result:



```text

September

```



\---



\# 📅 DAYNAME()



`DAYNAME()` returns the weekday name.



```sql

SELECT DAYNAME('2026-09-24');

```



Result:



```text

Thursday

```



This can help identify weekday and weekend patterns.



\---



\# 🔢 DAYOFWEEK()



`DAYOFWEEK()` returns a numeric weekday value.



In MySQL:



```text

Sunday    = 1

Monday    = 2

Tuesday   = 3

Wednesday = 4

Thursday  = 5

Friday    = 6

Saturday  = 7

```



Example:



```sql

SELECT DAYOFWEEK('2026-09-24');

```



\---



\# 🧭 DAYOFYEAR()



`DAYOFYEAR()` returns the position of a date within the year.



```sql

SELECT DAYOFYEAR('2026-09-24');

```



This is useful for yearly progress and seasonal analysis.



\---



\# 📊 WEEK()



`WEEK()` returns the week number.



```sql

SELECT WEEK('2026-09-24');

```



Weekly grouping is frequently used in reporting dashboards.



\---



\# 🧱 QUARTER()



`QUARTER()` divides the year into four business quarters.



```sql

SELECT QUARTER('2026-09-24');

```



The result is:



```text

3

```



Quarter mapping:



```text

Q1 → January to March

Q2 → April to June

Q3 → July to September

Q4 → October to December

```



\---



\# 📆 DATE()



`DATE()` extracts only the date portion from a datetime value.



```sql

SELECT DATE(NOW());

```



\---



\# 🕐 TIME()



`TIME()` extracts only the time portion.



```sql

SELECT TIME(NOW());

```



\---



\# ➖ DATEDIFF()



`DATEDIFF()` calculates the number of days between two dates.



```sql

SELECT DATEDIFF(

&#x20;   '2026-09-24',

&#x20;   '2026-09-01'

);

```



Result:



```text

23

```



This is extremely useful for:



\- Customer tenure

\- Delivery duration

\- Employee tenure

\- Subscription age

\- Project duration



\---



\# ⌛ TIMESTAMPDIFF()



`TIMESTAMPDIFF()` provides more control over the unit used in the calculation.



Syntax:



```sql

TIMESTAMPDIFF(

&#x20;   unit,

&#x20;   start\_date,

&#x20;   end\_date

)

```



Example:



```sql

SELECT TIMESTAMPDIFF(

&#x20;   YEAR,

&#x20;   '2020-01-01',

&#x20;   CURDATE()

);

```



Possible units include:



```text

SECOND

MINUTE

HOUR

DAY

WEEK

MONTH

QUARTER

YEAR

```



\---



\# ➕ DATE\_ADD()



`DATE\_ADD()` adds a time interval to a date.



```sql

SELECT DATE\_ADD(

&#x20;   CURDATE(),

&#x20;   INTERVAL 30 DAY

);

```



This returns the date 30 days from today.



\---



\# ➖ DATE\_SUB()



`DATE\_SUB()` subtracts an interval.



```sql

SELECT DATE\_SUB(

&#x20;   CURDATE(),

&#x20;   INTERVAL 30 DAY

);

```



This returns the date 30 days before today.



\---



\# 🧱 INTERVAL



`INTERVAL` defines the amount and unit used in date arithmetic.



Examples:



```sql

INTERVAL 7 DAY

INTERVAL 2 MONTH

INTERVAL 1 YEAR

INTERVAL 6 HOUR

```



This makes SQL date calculations highly flexible.



\---



\# 🏁 LAST\_DAY()



`LAST\_DAY()` returns the final day of a month.



```sql

SELECT LAST\_DAY('2026-09-24');

```



Result:



```text

2026-09-30

```



This is useful for monthly reporting and billing calculations.



\---



\# 🎨 DATE\_FORMAT()



`DATE\_FORMAT()` converts a date into a custom display format.



Example:



```sql

SELECT DATE\_FORMAT(

&#x20;   '2026-09-24',

&#x20;   '%d-%m-%Y'

);

```



Result:



```text

24-09-2026

```



Another example:



```sql

SELECT DATE\_FORMAT(

&#x20;   '2026-09-24',

&#x20;   '%d %M %Y'

);

```



Result:



```text

24 September 2026

```



\---



\## Common Formatting Codes



| Code | Meaning |

|---|---|

| `%d` | Day |

| `%m` | Numeric month |

| `%M` | Month name |

| `%Y` | Four-digit year |

| `%y` | Two-digit year |

| `%H` | Hour |

| `%i` | Minutes |

| `%s` | Seconds |



\---



\# 🔎 Time-Based Filtering



Date functions become especially powerful inside `WHERE`.



Example:



```sql

SELECT \*

FROM orders

WHERE order\_date >= DATE\_SUB(

&#x20;   CURDATE(),

&#x20;   INTERVAL 30 DAY

);

```



This retrieves records from the last 30 days.



\---



\# 📊 Monthly Analysis



Dates can also be grouped into reporting periods.



```sql

SELECT

&#x20;   YEAR(order\_date) AS year,

&#x20;   MONTH(order\_date) AS month,

&#x20;   COUNT(\*) AS total\_orders

FROM orders

GROUP BY

&#x20;   YEAR(order\_date),

&#x20;   MONTH(order\_date);

```



This creates monthly activity summaries.



\---



\# 💼 Real-World Applications



Date and time functions are commonly used for:



\- Customer tenure analysis

\- Employee tenure

\- Order tracking

\- Delivery-time calculations

\- Subscription expiration

\- Monthly sales reporting

\- Weekly dashboards

\- Financial quarters

\- Customer churn analysis

\- Cohort analysis

\- SLA monitoring

\- Project deadlines

\- Age calculations

\- ETL pipelines



\---



\## ⚠️ Important Principle



Whenever possible, store dates using proper SQL date types such as:



```text

DATE

DATETIME

TIMESTAMP

```



rather than storing dates as ordinary strings.



Proper date types make filtering, sorting, comparison, and calculations significantly safer.



\---



\# 💻 Practice



Today's exercises include:



\- Retrieving the current date

\- Retrieving timestamps

\- Extracting year, month, and day

\- Finding month names

\- Finding weekday names

\- Determining quarters

\- Calculating days between dates

\- Calculating years and months between dates

\- Adding intervals

\- Subtracting intervals

\- Finding month-end dates

\- Formatting dates

\- Creating recent-record filters

\- Performing monthly analysis

\- Building time-based reports



All practice queries are available in:



`queries.sql`



\---



\# 🎯 What I Learned



Today I learned how SQL handles date and time data using built-in functions.



I learned how functions such as `YEAR()`, `MONTH()`, `DAYNAME()`, and `QUARTER()` can extract useful calendar information from dates.



I also learned how `DATEDIFF()` and `TIMESTAMPDIFF()` calculate durations, while `DATE\_ADD()` and `DATE\_SUB()` perform date arithmetic.



Finally, I explored how `DATE\_FORMAT()` transforms dates for reporting and how date functions can be used to build dynamic filters such as the last 7, 30, or 90 days.



These techniques are essential for business analytics because most real-world datasets contain a time dimension.



\---



\## 📈 Challenge Progress



\*\*Day 17 / 30 ✅\*\*



Previous: \*\*Day 16 - String Functions \& Text Manipulation\*\*



Next: \*\*Day 18 - Common Table Expressions (CTEs)\*\*

