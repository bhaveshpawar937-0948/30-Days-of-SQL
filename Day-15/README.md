\# Day 15 - NULL Handling with COALESCE, IFNULL \& NULLIF 🧩



Welcome to \*\*Day 15 of my 30 Days of SQL Challenge\*\*.



Today I explored how SQL handles `NULL` values and learned several functions and techniques for safely working with missing data.



Real-world datasets are rarely perfectly complete. Customer phone numbers may be missing, employee manager IDs may be unknown, optional fields may be empty, and calculations can sometimes produce invalid results.



Understanding `NULL` is therefore essential for reliable SQL analysis.



\---



\## 📚 Concepts Covered



\- Understanding `NULL`

\- `IS NULL`

\- `IS NOT NULL`

\- Why `= NULL` does not work

\- Three-valued SQL logic

\- `COALESCE()`

\- `IFNULL()`

\- `NULLIF()`

\- Replacing missing values

\- Creating fallback values

\- Preventing division-by-zero errors

\- NULL-safe calculations

\- NULL handling with aggregates

\- NULL handling with `CASE`



\---



\## 🧠 What Does NULL Mean?



`NULL` represents a value that is:



\- Missing

\- Unknown

\- Not available

\- Not applicable



It is important to understand that:



```text

NULL ≠ 0

NULL ≠ ''

NULL ≠ FALSE

```



`NULL` means that SQL does not currently have a known value.



\---



\## ❌ Why = NULL Does Not Work



This is incorrect:



```sql

SELECT \*

FROM employees

WHERE manager\_id = NULL;

```



SQL cannot compare an unknown value using the normal equality operator.



Instead, use:



```sql

SELECT \*

FROM employees

WHERE manager\_id IS NULL;

```



For non-NULL values:



```sql

SELECT \*

FROM employees

WHERE manager\_id IS NOT NULL;

```



\---



\## 🔺 Three-Valued Logic



Normal Boolean logic usually contains:



```text

TRUE

FALSE

```



SQL introduces another logical state:



```text

UNKNOWN

```



For example:



```sql

NULL = NULL

```



does not evaluate to `TRUE`.



It evaluates to:



```text

UNKNOWN

```



This is one reason NULL handling requires special operators.



\---



\# COALESCE()



`COALESCE()` returns the first non-NULL value from a list of expressions.



Syntax:



```sql

COALESCE(value1, value2, value3, ...)

```



Example:



```sql

SELECT

&#x20;   name,

&#x20;   COALESCE(phone, 'Phone Not Available') AS phone

FROM students;

```



If `phone` contains a value, SQL returns it.



If `phone` is NULL, SQL returns:



```text

Phone Not Available

```



\---



\## Multiple Fallback Values



`COALESCE()` can check several possible values.



```sql

COALESCE(work\_email, personal\_email, 'No Email Available')

```



SQL checks the values from left to right.



The first non-NULL value wins.



Conceptually:



```text

work\_email

&#x20;   ↓ NULL?

personal\_email

&#x20;   ↓ NULL?

fallback value

```



\---



\# IFNULL()



MySQL also provides:



```sql

IFNULL(expression, replacement)

```



Example:



```sql

SELECT

&#x20;   employee\_name,

&#x20;   IFNULL(manager\_id, 0) AS manager\_id

FROM employees;

```



If `manager\_id` is NULL, `0` is returned.



\---



\## COALESCE vs IFNULL



`IFNULL()` accepts two arguments:



```sql

IFNULL(value, replacement)

```



`COALESCE()` can accept multiple arguments:



```sql

COALESCE(value1, value2, value3, replacement)

```



`COALESCE()` is also part of the SQL standard and is generally more portable across database systems.



\---



\# NULLIF()



`NULLIF()` works differently.



Syntax:



```sql

NULLIF(value1, value2)

```



If both values are equal, SQL returns:



```text

NULL

```



Otherwise it returns the first value.



Example:



```sql

SELECT NULLIF(10, 10);

```



Result:



```text

NULL

```



But:



```sql

SELECT NULLIF(10, 5);

```



returns:



```text

10

```



\---



\## 🛡️ Preventing Division by Zero



One extremely useful application of `NULLIF()` is preventing division-by-zero errors.



Instead of:



```sql

total\_sales / number\_of\_orders

```



we can write:



```sql

total\_sales / NULLIF(number\_of\_orders, 0)

```



If:



```text

number\_of\_orders = 0

```



then:



```sql

NULLIF(number\_of\_orders, 0)

```



returns NULL.



SQL therefore avoids attempting division by zero.



\---



\## 🔗 COALESCE + NULLIF



The functions can also work together.



```sql

COALESCE(

&#x20;   total\_sales / NULLIF(number\_of\_orders, 0),

&#x20;   0

)

```



The logic becomes:



```text

If denominator = 0

&#x20;       ↓

NULLIF → NULL

&#x20;       ↓

Calculation → NULL

&#x20;       ↓

COALESCE → 0

```



This pattern is extremely useful in reporting and analytics.



\---



\## 📊 NULL and Aggregate Functions



Most aggregate functions ignore NULL values.



For example:



```sql

AVG(salary)

```



does not treat NULL salary values as zero.



It simply excludes them from the calculation.



Similarly:



```sql

COUNT(column\_name)

```



counts only non-NULL values.



However:



```sql

COUNT(\*)

```



counts every row.



This distinction is important.



\---



\## Example



Suppose a table contains:



| employee | bonus |

|---|---:|

| A | 5000 |

| B | NULL |

| C | 3000 |



Then:



```sql

COUNT(\*)

```



returns:



```text

3

```



while:



```sql

COUNT(bonus)

```



returns:



```text

2

```



\---



\## NULL Handling with CASE



`CASE` can also classify missing values.



```sql

CASE

&#x20;   WHEN manager\_id IS NULL

&#x20;       THEN 'Top-Level Employee'

&#x20;   ELSE 'Reports to Manager'

END

```



This allows missing values to become meaningful business labels.



\---



\## 💼 Real-World Uses



NULL handling is commonly needed for:



\- Missing customer details

\- Optional contact information

\- Employee hierarchy data

\- Incomplete survey responses

\- Missing transaction values

\- Data-cleaning pipelines

\- Dashboard reporting

\- ETL validation

\- Safe ratio calculations

\- Default display values

\- Missing-category classification



\---



\## 🧹 Data Cleaning Example



Instead of returning:



```text

NULL

```



to a dashboard, we can return:



```sql

COALESCE(city, 'Unknown')

```



This produces a cleaner report while preserving the original database value.



\---



\## ⚠️ Important Principle



Replacing NULL does not always mean the underlying value should actually become zero.



For example:



```text

salary = NULL

```



means the salary is unknown.



It does NOT necessarily mean:



```text

salary = 0

```



The replacement should depend on the meaning of the data.



\---



\## 💻 Practice



Today's exercises include:



\- Detecting NULL values

\- Detecting non-NULL values

\- Replacing NULL values

\- Using fallback values

\- Comparing `COALESCE()` and `IFNULL()`

\- Using `NULLIF()`

\- Preventing division by zero

\- Combining `COALESCE()` with `NULLIF()`

\- Counting NULL values

\- Calculating NULL percentages

\- Classifying missing data

\- Building NULL-safe reports



All queries are available in:



`queries.sql`



\---



\## 🎯 What I Learned



Today I learned that `NULL` requires special treatment because it represents missing or unknown information rather than an ordinary value.



I learned how `IS NULL` and `IS NOT NULL` detect missing values, while `COALESCE()` and `IFNULL()` provide useful fallback values.



I also learned how `NULLIF()` can deliberately convert specific values into NULL and how this technique can prevent problems such as division by zero.



Proper NULL handling is essential for reliable analytics, data cleaning, ETL pipelines, and production SQL reporting.



\---



\## 📈 Challenge Progress



\*\*Day 15 / 30 ✅\*\*



Previous: \*\*Day 14 - CASE Expressions \& Conditional Logic\*\*



Next: \*\*Day 16 - String Functions \& Text Manipulation\*\*

