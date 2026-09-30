\# Day 21 - LAG, LEAD, FIRST\_VALUE \& LAST\_VALUE 🔭



Welcome to \*\*Day 21 of my 30 Days of SQL Challenge\*\*.



Today I explored four powerful SQL window functions used to compare a row with other rows without performing a self join:



\- `LAG()`

\- `LEAD()`

\- `FIRST\_VALUE()`

\- `LAST\_VALUE()`



These functions are especially useful when analyzing changes, trends, previous and next records, salary differences, sequential performance, and time-series datasets.



\---



\## 📚 Concepts Covered



\- `LAG()`

\- `LEAD()`

\- `FIRST\_VALUE()`

\- `LAST\_VALUE()`

\- Previous-row comparisons

\- Next-row comparisons

\- Offsets

\- Default values

\- `PARTITION BY`

\- `ORDER BY`

\- Window frames

\- Salary change analysis

\- Score change analysis

\- First and last values within groups

\- CTEs with navigation window functions



\---



\# 🧠 LAG()



`LAG()` accesses a value from a previous row.



Basic syntax:



```sql

LAG(column) OVER (

&#x20;   ORDER BY column

)

```



Example:



```sql

SELECT

&#x20;   employee\_id,

&#x20;   employee\_name,

&#x20;   salary,



&#x20;   LAG(salary) OVER (

&#x20;       ORDER BY employee\_id

&#x20;   ) AS previous\_salary



FROM employees;

```



This lets the current employee row see the salary from the previous row.



\---



\# 📉 Calculate Change from Previous Row



`LAG()` becomes especially useful when calculating differences.



```sql

SELECT

&#x20;   employee\_name,

&#x20;   salary,



&#x20;   salary - LAG(salary) OVER (

&#x20;       ORDER BY employee\_id

&#x20;   ) AS salary\_change



FROM employees;

```



Conceptually:



```text

Current salary

\-

Previous salary

=

Change

```



\---



\# 🔭 LEAD()



`LEAD()` looks forward instead of backward.



```sql

SELECT

&#x20;   employee\_name,

&#x20;   salary,



&#x20;   LEAD(salary) OVER (

&#x20;       ORDER BY employee\_id

&#x20;   ) AS next\_salary



FROM employees;

```



The current row can now access the value from the next row.



\---



\# ⚔️ LAG vs LEAD



```text

LAG  → Look backward

LEAD → Look forward

```



Example sequence:



```text

50000

60000

70000

```



For the second row:



```text

LAG  → 50000

Current → 60000

LEAD → 70000

```



\---



\# 🔢 Using an Offset



By default, `LAG()` and `LEAD()` move one row.



We can change that.



```sql

LAG(salary, 2) OVER (

&#x20;   ORDER BY employee\_id

)

```



This looks two rows backward.



Similarly:



```sql

LEAD(salary, 2) OVER (

&#x20;   ORDER BY employee\_id

)

```



looks two rows forward.



\---



\# 🛡️ Default Values



When no previous or next row exists, SQL normally returns `NULL`.



MySQL allows a default value:



```sql

LAG(salary, 1, 0) OVER (

&#x20;   ORDER BY employee\_id

)

```



The first row will receive `0` instead of `NULL`.



\---



\# 🏢 LAG Within Departments



`PARTITION BY` restarts the comparison for each department.



```sql

LAG(salary) OVER (

&#x20;   PARTITION BY department

&#x20;   ORDER BY salary

)

```



This compares employees only with other employees in the same department.



\---



\# 🥇 FIRST\_VALUE()



`FIRST\_VALUE()` returns the first value inside a window.



Example:



```sql

SELECT

&#x20;   employee\_name,

&#x20;   department,

&#x20;   salary,



&#x20;   FIRST\_VALUE(salary) OVER (

&#x20;       PARTITION BY department

&#x20;       ORDER BY salary DESC

&#x20;   ) AS highest\_department\_salary



FROM employees;

```



Because salaries are ordered descending, the first value is the highest salary.



\---



\# 🏁 LAST\_VALUE()



`LAST\_VALUE()` returns the final value in a window.



However, it requires careful use of the window frame.



Correct pattern:



```sql

LAST\_VALUE(salary) OVER (

&#x20;   PARTITION BY department

&#x20;   ORDER BY salary DESC

&#x20;   ROWS BETWEEN UNBOUNDED PRECEDING

&#x20;   AND UNBOUNDED FOLLOWING

)

```



This ensures SQL considers the entire partition.



\---



\# ⚠️ Why LAST\_VALUE Needs a Window Frame



Without an explicit frame, the window may end at the current row.



That can cause:



```sql

LAST\_VALUE(salary)

```



to return the current row's salary rather than the final value for the entire department.



Using:



```sql

ROWS BETWEEN UNBOUNDED PRECEDING

AND UNBOUNDED FOLLOWING

```



makes the complete partition available.



\---



\# 📊 Highest and Lowest Salary Together



```sql

SELECT

&#x20;   employee\_name,

&#x20;   department,

&#x20;   salary,



&#x20;   FIRST\_VALUE(salary) OVER (

&#x20;       PARTITION BY department

&#x20;       ORDER BY salary DESC

&#x20;   ) AS highest\_salary,



&#x20;   LAST\_VALUE(salary) OVER (

&#x20;       PARTITION BY department

&#x20;       ORDER BY salary DESC

&#x20;       ROWS BETWEEN UNBOUNDED PRECEDING

&#x20;       AND UNBOUNDED FOLLOWING

&#x20;   ) AS lowest\_salary



FROM employees;

```



Each employee can now be compared with both extremes in their department.



\---



\# 🎓 Student Score Comparison



These functions also work well for student performance.



```sql

SELECT

&#x20;   student\_name,

&#x20;   score,



&#x20;   LAG(score) OVER (

&#x20;       ORDER BY score DESC

&#x20;   ) AS previous\_score



FROM student\_scores;

```



This can reveal the gap between neighboring performers.



\---



\# 🔄 Sequential Change Analysis



A common analytical pattern is:



```sql

current\_value - LAG(current\_value)

```



For example:



```sql

score -

LAG(score) OVER (

&#x20;   ORDER BY student\_id

)

```



This calculates the change between consecutive student records.



In real business datasets, the same idea is used for:



\- Daily sales change

\- Monthly revenue growth

\- Stock-price change

\- Customer activity change

\- Website traffic change

\- Inventory movement



\---



\# 🧩 CTE + LAG



A CTE can make navigation analysis easier to read.



```sql

WITH salary\_changes AS (

&#x20;   SELECT

&#x20;       employee\_name,

&#x20;       salary,



&#x20;       LAG(salary) OVER (

&#x20;           ORDER BY employee\_id

&#x20;       ) AS previous\_salary



&#x20;   FROM employees

)



SELECT

&#x20;   employee\_name,

&#x20;   salary,

&#x20;   previous\_salary,

&#x20;   salary - previous\_salary AS difference



FROM salary\_changes;

```



\---



\# 💼 Real-World Applications



These functions are commonly used for:



\- Month-over-month revenue change

\- Previous transaction comparison

\- Next scheduled event

\- Employee salary comparisons

\- Customer purchase behavior

\- Stock-price changes

\- Sales trends

\- Churn analysis

\- Sequential events

\- Performance tracking

\- First purchase analysis

\- Latest value comparisons

\- Financial reporting



\---



\# 🆚 Navigation Functions Summary



| Function | Purpose |

|---|---|

| `LAG()` | Access a previous row |

| `LEAD()` | Access a following row |

| `FIRST\_VALUE()` | Return first value in a window |

| `LAST\_VALUE()` | Return final value in a window |



\---



\# 💻 Practice



Today's exercises include:



\- Previous employee salary

\- Next employee salary

\- Salary differences

\- Multi-row offsets

\- Department-level comparisons

\- Student score differences

\- Previous and next scores

\- Highest department salary

\- Lowest department salary

\- Distance from first value

\- Distance from last value

\- CTE-based comparison reports

\- Sequential analysis

\- Navigation-based employee analytics



All practice queries are available in:



`queries.sql`



\---



\# 🎯 What I Learned



Today I learned how navigation window functions allow SQL queries to look backward and forward across rows.



`LAG()` retrieves previous values while `LEAD()` retrieves upcoming values.



I also learned how `FIRST\_VALUE()` and `LAST\_VALUE()` identify boundary values inside a window.



An especially important lesson was understanding window frames with `LAST\_VALUE()`, because the correct frame ensures the function examines the entire partition.



These functions are extremely useful for trend analysis, financial reporting, sequential comparisons, customer behavior analysis, and time-series analytics.



\---



\## 📈 Challenge Progress



\*\*Day 21 / 30 ✅\*\*



Previous: \*\*Day 20 - Aggregate Window Functions \& Running Totals\*\*



Next: \*\*Day 22 - NTILE, PERCENT\_RANK \& CUME\_DIST\*\*

