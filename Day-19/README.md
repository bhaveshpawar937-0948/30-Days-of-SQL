\# Day 19 - Window Functions: ROW\_NUMBER, RANK \& DENSE\_RANK 🪟



Welcome to \*\*Day 19 of my 30 Days of SQL Challenge\*\*.



Today I explored \*\*SQL Window Functions\*\*, focusing on three important ranking functions:



\- `ROW\_NUMBER()`

\- `RANK()`

\- `DENSE\_RANK()`



Window functions allow calculations across related rows while still keeping every individual row in the result.



Unlike `GROUP BY`, which combines rows into summary records, window functions preserve the original rows.



This makes them extremely useful for rankings, leaderboards, top-N analysis, employee comparisons, customer analytics, and reporting.



\---



\## 📚 Concepts Covered



\- Window functions

\- `OVER()`

\- `PARTITION BY`

\- `ORDER BY` inside windows

\- `ROW\_NUMBER()`

\- `RANK()`

\- `DENSE\_RANK()`

\- Global ranking

\- Ranking within groups

\- Handling ties

\- Top-N per group

\- Bottom-N per group

\- Combining CTEs with window functions

\- Salary rankings

\- Student leaderboards



\---



\# 🧠 What is a Window Function?



A window function performs a calculation across a group of related rows without collapsing those rows.



Basic syntax:



```sql

function\_name() OVER (

&#x20;   PARTITION BY column

&#x20;   ORDER BY column

)

```



For example:



```sql

SELECT

&#x20;   employee\_name,

&#x20;   salary,

&#x20;   ROW\_NUMBER() OVER (

&#x20;       ORDER BY salary DESC

&#x20;   ) AS salary\_position

FROM employees;

```



Every employee remains visible while SQL assigns each one a position.



\---



\# 🪟 OVER()



`OVER()` tells SQL that a function should operate over a window of rows.



Example:



```sql

ROW\_NUMBER() OVER (

&#x20;   ORDER BY salary DESC

)

```



Without `OVER()`, ranking window functions cannot operate.



\---



\# 🔢 ROW\_NUMBER()



`ROW\_NUMBER()` gives every row a unique sequential number.



Example:



```sql

SELECT

&#x20;   employee\_name,

&#x20;   salary,



&#x20;   ROW\_NUMBER() OVER (

&#x20;       ORDER BY salary DESC

&#x20;   ) AS row\_number



FROM employees;

```



Possible result:



```text

Employee   Salary   Row

A          90000    1

B          85000    2

C          85000    3

D          70000    4

```



Even though B and C have identical salaries, they receive different row numbers.



\---



\# 🏆 RANK()



`RANK()` assigns the same ranking to tied values.



However, the next ranking contains a gap.



Example:



```sql

SELECT

&#x20;   employee\_name,

&#x20;   salary,



&#x20;   RANK() OVER (

&#x20;       ORDER BY salary DESC

&#x20;   ) AS salary\_rank



FROM employees;

```



Possible result:



```text

Employee   Salary   Rank

A          90000    1

B          85000    2

C          85000    2

D          70000    4

```



Notice that rank `3` is skipped.



\---



\# 🥇 DENSE\_RANK()



`DENSE\_RANK()` also assigns equal ranks to ties.



Unlike `RANK()`, it does not create gaps.



```sql

SELECT

&#x20;   employee\_name,

&#x20;   salary,



&#x20;   DENSE\_RANK() OVER (

&#x20;       ORDER BY salary DESC

&#x20;   ) AS salary\_rank



FROM employees;

```



Result:



```text

Employee   Salary   Rank

A          90000    1

B          85000    2

C          85000    2

D          70000    3

```



\---



\# ⚔️ ROW\_NUMBER vs RANK vs DENSE\_RANK



Suppose salaries are:



```text

90000

85000

85000

70000

```



The ranking functions produce:



| Salary | ROW\_NUMBER | RANK | DENSE\_RANK |

|---:|---:|---:|---:|

| 90000 | 1 | 1 | 1 |

| 85000 | 2 | 2 | 2 |

| 85000 | 3 | 2 | 2 |

| 70000 | 4 | 4 | 3 |



The difference becomes important whenever duplicate values exist.



\---



\# 🧩 PARTITION BY



`PARTITION BY` divides rows into separate groups before applying the window function.



Example:



```sql

SELECT

&#x20;   employee\_name,

&#x20;   department,

&#x20;   salary,



&#x20;   RANK() OVER (

&#x20;       PARTITION BY department

&#x20;       ORDER BY salary DESC

&#x20;   ) AS department\_rank



FROM employees;

```



Instead of ranking every employee together, SQL creates a separate ranking for every department.



Conceptually:



```text

Engineering

&#x20;   Rank 1

&#x20;   Rank 2

&#x20;   Rank 3



Analytics

&#x20;   Rank 1

&#x20;   Rank 2



HR

&#x20;   Rank 1

&#x20;   Rank 2

```



Each partition gets its own ranking.



\---



\# 🌍 Global Ranking



Without `PARTITION BY`:



```sql

RANK() OVER (

&#x20;   ORDER BY salary DESC

)

```



all employees compete in one ranking.



\---



\# 🏢 Department Ranking



With:



```sql

RANK() OVER (

&#x20;   PARTITION BY department

&#x20;   ORDER BY salary DESC

)

```



employees compete only against others in their department.



\---



\# 🎯 Top-N Per Group



One of the most useful applications of window functions is finding the top N records within every category.



First assign rankings:



```sql

WITH ranked\_employees AS (

&#x20;   SELECT

&#x20;       employee\_name,

&#x20;       department,

&#x20;       salary,



&#x20;       ROW\_NUMBER() OVER (

&#x20;           PARTITION BY department

&#x20;           ORDER BY salary DESC

&#x20;       ) AS salary\_position



&#x20;   FROM employees

)

```



Then filter:



```sql

SELECT \*

FROM ranked\_employees

WHERE salary\_position <= 3;

```



This returns the top three employees from each department.



\---



\# 🧱 Why Use a CTE?



Window functions are calculated after the normal `WHERE` filtering stage.



Therefore, this pattern is extremely useful:



```text

Table

&#x20; ↓

Window Function

&#x20; ↓

CTE

&#x20; ↓

Filter Ranking

```



Example:



```sql

WITH ranked\_data AS (

&#x20;   SELECT

&#x20;       employee\_name,

&#x20;       salary,



&#x20;       RANK() OVER (

&#x20;           ORDER BY salary DESC

&#x20;       ) AS salary\_rank



&#x20;   FROM employees

)



SELECT \*

FROM ranked\_data

WHERE salary\_rank <= 5;

```



This combines yesterday's CTE knowledge with today's window functions.



\---



\# 📊 Student Leaderboards



Window functions can also create academic leaderboards.



```sql

SELECT

&#x20;   student\_name,

&#x20;   department,

&#x20;   score,



&#x20;   DENSE\_RANK() OVER (

&#x20;       ORDER BY score DESC

&#x20;   ) AS overall\_rank



FROM student\_scores;

```



Or department-specific rankings:



```sql

DENSE\_RANK() OVER (

&#x20;   PARTITION BY department

&#x20;   ORDER BY score DESC

)

```



\---



\# 💼 Real-World Applications



Ranking window functions are commonly used for:



\- Employee salary rankings

\- Student leaderboards

\- Top-selling products

\- Best customers

\- Top sales representatives

\- Department performance

\- Top-N records per category

\- Customer segmentation

\- Product rankings

\- Financial analysis

\- Dashboard leaderboards

\- Duplicate identification

\- Selecting latest records

\- Analytical reporting



\---



\# ⚠️ Important Difference from GROUP BY



`GROUP BY` reduces multiple rows into summaries.



For example:



```sql

SELECT

&#x20;   department,

&#x20;   AVG(salary)

FROM employees

GROUP BY department;

```



may return one row per department.



A window function preserves every employee:



```sql

SELECT

&#x20;   employee\_name,

&#x20;   department,

&#x20;   salary,



&#x20;   RANK() OVER (

&#x20;       PARTITION BY department

&#x20;       ORDER BY salary DESC

&#x20;   ) AS salary\_rank



FROM employees;

```



Every employee remains visible.



\---



\# 💻 Practice



Today's exercises include:



\- Sequential row numbering

\- Global salary rankings

\- Comparing ranking functions

\- Department salary rankings

\- Student leaderboards

\- Department student rankings

\- Top employees overall

\- Top employees per department

\- Highest-paid employee per department

\- Top students per department

\- Bottom-ranked employees

\- Ranking after filtering

\- Ranking aggregated results

\- Combining CTEs and window functions



All practice queries are available in:



`queries.sql`



\---



\# 🎯 What I Learned



Today I learned how SQL window functions perform calculations across related rows without collapsing the original dataset.



`ROW\_NUMBER()` gives every row a unique sequence number, while `RANK()` and `DENSE\_RANK()` handle tied values differently.



I also learned how `PARTITION BY` creates independent ranking groups, making it possible to rank employees within departments or students within courses.



Finally, I combined CTEs with window functions to solve practical Top-N-per-group problems.



Window functions are one of the most powerful SQL features for analytics because they allow row-level information and group-level calculations to exist together in the same result.



\---



\## 📈 Challenge Progress



\*\*Day 19 / 30 ✅\*\*



Previous: \*\*Day 18 - Common Table Expressions (CTEs)\*\*



Next: \*\*Day 20 - Aggregate Window Functions \& Running Totals\*\*

