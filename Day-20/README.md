\# Day 20 - Aggregate Window Functions \& Running Totals 📈



Welcome to \*\*Day 20 of my 30 Days of SQL Challenge\*\*.



Today I explored \*\*aggregate window functions\*\*, which combine familiar aggregate functions such as `SUM()`, `AVG()`, `COUNT()`, `MIN()`, and `MAX()` with the `OVER()` clause.



Unlike normal aggregation with `GROUP BY`, window aggregates allow calculations across related rows while still keeping every original row visible.



This makes them extremely useful for running totals, moving averages, department comparisons, cumulative metrics, and analytical dashboards.



\---



\## 📚 Concepts Covered



\- Aggregate window functions

\- `SUM() OVER()`

\- `AVG() OVER()`

\- `COUNT() OVER()`

\- `MIN() OVER()`

\- `MAX() OVER()`

\- `PARTITION BY`

\- `ORDER BY` inside windows

\- Running totals

\- Cumulative averages

\- Department-level calculations

\- Overall vs partitioned metrics

\- Window frames

\- `ROWS BETWEEN`

\- `UNBOUNDED PRECEDING`

\- Moving averages

\- Percentage-of-total calculations

\- Cumulative contribution analysis



\---



\# 🧠 Aggregate Functions vs Aggregate Window Functions



A normal aggregate query might look like:



```sql

SELECT

&#x20;   department,

&#x20;   AVG(salary) AS average\_salary

FROM employees

GROUP BY department;

```



This reduces the table to one row per department.



An aggregate window function:



```sql

SELECT

&#x20;   employee\_name,

&#x20;   department,

&#x20;   salary,



&#x20;   AVG(salary) OVER (

&#x20;       PARTITION BY department

&#x20;   ) AS department\_average



FROM employees;

```



keeps every employee visible.



\---



\# 🪟 SUM() OVER()



`SUM()` can be used as a window function.



```sql

SELECT

&#x20;   employee\_name,

&#x20;   salary,



&#x20;   SUM(salary) OVER ()

&#x20;       AS total\_payroll



FROM employees;

```



Every employee row now displays the total company payroll.



\---



\# 🏢 PARTITION BY



`PARTITION BY` divides the data into independent groups.



```sql

SUM(salary) OVER (

&#x20;   PARTITION BY department

)

```



This calculates the total salary separately for every department.



Each employee can therefore be shown alongside their department's total payroll.



\---



\# 📊 AVG() OVER()



A department average can be calculated without losing individual rows.



```sql

SELECT

&#x20;   employee\_name,

&#x20;   department,

&#x20;   salary,



&#x20;   AVG(salary) OVER (

&#x20;       PARTITION BY department

&#x20;   ) AS department\_average



FROM employees;

```



This makes comparisons between individual values and group averages much easier.



\---



\# 🔢 COUNT() OVER()



`COUNT()` can display group sizes.



```sql

SELECT

&#x20;   employee\_name,

&#x20;   department,



&#x20;   COUNT(\*) OVER (

&#x20;       PARTITION BY department

&#x20;   ) AS department\_size



FROM employees;

```



Every employee row shows how many employees belong to that department.



\---



\# 📉 MIN() and MAX() OVER()



We can display department salary ranges:



```sql

SELECT

&#x20;   employee\_name,

&#x20;   department,

&#x20;   salary,



&#x20;   MIN(salary) OVER (

&#x20;       PARTITION BY department

&#x20;   ) AS department\_minimum,



&#x20;   MAX(salary) OVER (

&#x20;       PARTITION BY department

&#x20;   ) AS department\_maximum



FROM employees;

```



\---



\# 🏃 Running Total



A running total accumulates values as rows progress.



Example:



```sql

SELECT

&#x20;   employee\_id,

&#x20;   employee\_name,

&#x20;   salary,



&#x20;   SUM(salary) OVER (

&#x20;       ORDER BY employee\_id

&#x20;       ROWS BETWEEN UNBOUNDED PRECEDING

&#x20;       AND CURRENT ROW

&#x20;   ) AS running\_salary



FROM employees;

```



Conceptually:



```text

Row 1 → salary 1

Row 2 → salary 1 + salary 2

Row 3 → salary 1 + salary 2 + salary 3

...

```



\---



\# 🧱 Window Frames



The window frame determines which rows participate in a calculation.



This:



```sql

ROWS BETWEEN UNBOUNDED PRECEDING

AND CURRENT ROW

```



means:



```text

Start at the first row

↓

Continue through the current row

```



This is a common pattern for cumulative calculations.



\---



\# 🏢 Running Total Within Departments



Running totals can restart for every department.



```sql

SUM(salary) OVER (

&#x20;   PARTITION BY department

&#x20;   ORDER BY salary

&#x20;   ROWS BETWEEN UNBOUNDED PRECEDING

&#x20;   AND CURRENT ROW

)

```



Each department gets its own cumulative calculation.



\---



\# 📈 Cumulative Average



Running averages work the same way.



```sql

AVG(salary) OVER (

&#x20;   ORDER BY employee\_id

&#x20;   ROWS BETWEEN UNBOUNDED PRECEDING

&#x20;   AND CURRENT ROW

)

```



Each row shows the average of all values seen so far.



\---



\# 🌊 Moving Average



A moving average considers only a limited number of nearby rows.



Example:



```sql

AVG(score) OVER (

&#x20;   ORDER BY student\_id

&#x20;   ROWS BETWEEN 2 PRECEDING

&#x20;   AND CURRENT ROW

)

```



This calculates an average using:



```text

Previous 2 rows

\+

Current row

```



This type of analysis is widely used with time-series data.



\---



\# 💯 Percentage of Total



Window functions make percentage calculations much easier.



```sql

SELECT

&#x20;   employee\_name,

&#x20;   salary,



&#x20;   ROUND(

&#x20;       salary \* 100.0 /

&#x20;       SUM(salary) OVER (),

&#x20;       2

&#x20;   ) AS payroll\_percentage



FROM employees;

```



This shows how much each employee's salary contributes to total payroll.



\---



\# 🏢 Percentage Within Department



We can also calculate contribution inside a partition:



```sql

salary \* 100.0 /

SUM(salary) OVER (

&#x20;   PARTITION BY department

)

```



This gives each employee's percentage of department payroll.



\---



\# 🆚 GROUP BY vs Window Aggregates



\## GROUP BY



```text

Multiple rows

&#x20;    ↓

One summary row

```



\## Window Function



```text

Multiple rows remain visible

&#x20;    +

Summary information added

```



This difference is extremely important in analytical SQL.



\---



\# 💼 Real-World Applications



Aggregate window functions are commonly used for:



\- Running sales totals

\- Cumulative revenue

\- Customer lifetime value

\- Department payroll analysis

\- Moving averages

\- Financial dashboards

\- Inventory trends

\- Monthly performance tracking

\- Percentage contribution analysis

\- Customer spending analysis

\- Student performance reports

\- KPI dashboards

\- Time-series analytics



\---



\# ⚠️ Important Point



`ORDER BY` inside a window is different from the final query's `ORDER BY`.



For example:



```sql

SUM(salary) OVER (

&#x20;   ORDER BY employee\_id

)

```



controls how the running calculation is performed.



The final:



```sql

ORDER BY employee\_name;

```



controls only how the completed result is displayed.



\---



\# 💻 Practice



Today's exercises include:



\- Company-wide salary totals

\- Department payroll totals

\- Department average salaries

\- Department employee counts

\- Minimum and maximum window calculations

\- Running salary totals

\- Department running totals

\- Student cumulative scores

\- Cumulative averages

\- Moving averages

\- Percentage-of-total calculations

\- Department contribution percentages

\- Salary-range comparisons

\- CTE + window aggregate combinations

\- Final analytical reports



All practice queries are available in:



`queries.sql`



\---



\# 🎯 What I Learned



Today I learned how aggregate functions can be transformed into analytical window functions using the `OVER()` clause.



Instead of collapsing rows with `GROUP BY`, window aggregates let me keep every record while adding group-level or overall metrics.



I also learned how `ORDER BY` and window frames can create running totals, cumulative averages, and moving calculations.



Finally, I learned how partitioned totals make percentage-of-group calculations straightforward.



These techniques are especially powerful for dashboards, financial analysis, customer analytics, reporting, and time-series data.



\---



\## 📈 Challenge Progress



\*\*Day 20 / 30 ✅\*\*



Previous: \*\*Day 19 - Window Functions: ROW\_NUMBER, RANK \& DENSE\_RANK\*\*



Next: \*\*Day 21 - LAG, LEAD, FIRST\_VALUE \& LAST\_VALUE\*\*

