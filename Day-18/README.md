\# Day 18 - Common Table Expressions (CTEs) 🧱



Welcome to \*\*Day 18 of my 30 Days of SQL Challenge\*\*.



Today I explored \*\*Common Table Expressions\*\*, commonly called \*\*CTEs\*\*.



A CTE allows us to create a temporary named result set that exists only while a SQL statement is running.



CTEs are useful for breaking large SQL queries into smaller, readable steps.



\---



\## 📚 Concepts Covered



\- `WITH`

\- Common Table Expressions

\- Naming a CTE

\- Selecting from a CTE

\- Filtering CTE results

\- Aggregation inside CTEs

\- Joining CTEs with tables

\- Multiple CTEs

\- Chained CTEs

\- Replacing nested subqueries

\- Replacing derived tables

\- Reusing calculated results

\- Building analytical pipelines



\---



\# 🧠 What is a CTE?



A Common Table Expression is a temporary result set defined using the `WITH` keyword.



Basic syntax:



```sql

WITH cte\_name AS (

&#x20;   SELECT ...

)

SELECT \*

FROM cte\_name;

```



Example:



```sql

WITH high\_salary\_employees AS (

&#x20;   SELECT

&#x20;       employee\_name,

&#x20;       department,

&#x20;       salary

&#x20;   FROM employees

&#x20;   WHERE salary >= 70000

)

SELECT \*

FROM high\_salary\_employees;

```



The CTE:



```text

high\_salary\_employees

```



acts like a temporary table during that query.



\---



\# 🧱 Basic Structure



A CTE has two main parts:



```text

WITH

&#x20;   CTE definition

&#x20;       ↓

Main query

```



Example:



```sql

WITH department\_salary AS (

&#x20;   SELECT

&#x20;       department,

&#x20;       AVG(salary) AS average\_salary

&#x20;   FROM employees

&#x20;   GROUP BY department

)

SELECT \*

FROM department\_salary;

```



\---



\# 🔍 Filtering CTE Results



The CTE can perform one task while the outer query performs another.



```sql

WITH department\_salary AS (

&#x20;   SELECT

&#x20;       department,

&#x20;       AVG(salary) AS average\_salary

&#x20;   FROM employees

&#x20;   GROUP BY department

)

SELECT \*

FROM department\_salary

WHERE average\_salary > 60000;

```



This separates:



```text

Step 1 → Calculate department averages

Step 2 → Filter the calculated results

```



\---



\# 📊 Aggregation Inside a CTE



CTEs work very well with aggregate functions.



```sql

WITH department\_stats AS (

&#x20;   SELECT

&#x20;       department,

&#x20;       COUNT(\*) AS employee\_count,

&#x20;       AVG(salary) AS average\_salary,

&#x20;       MAX(salary) AS highest\_salary

&#x20;   FROM employees

&#x20;   GROUP BY department

)

SELECT \*

FROM department\_stats;

```



The result can then be filtered, sorted, or joined.



\---



\# 🔗 Joining a CTE with a Table



A CTE can be joined just like a regular table.



```sql

WITH department\_average AS (

&#x20;   SELECT

&#x20;       department,

&#x20;       AVG(salary) AS average\_salary

&#x20;   FROM employees

&#x20;   GROUP BY department

)

SELECT

&#x20;   e.employee\_name,

&#x20;   e.department,

&#x20;   e.salary,

&#x20;   d.average\_salary

FROM employees AS e

JOIN department\_average AS d

&#x20;   ON e.department = d.department;

```



This makes it easy to compare individual rows against grouped statistics.



\---



\# 🧮 Compare Employees Against Department Average



```sql

WITH department\_average AS (

&#x20;   SELECT

&#x20;       department,

&#x20;       AVG(salary) AS average\_salary

&#x20;   FROM employees

&#x20;   GROUP BY department

)

SELECT

&#x20;   e.employee\_name,

&#x20;   e.department,

&#x20;   e.salary,

&#x20;   d.average\_salary

FROM employees AS e

JOIN department\_average AS d

&#x20;   ON e.department = d.department

WHERE e.salary > d.average\_salary;

```



This is often easier to read than a correlated subquery.



\---



\# 🧩 Multiple CTEs



A query can contain more than one CTE.



```sql

WITH

employee\_stats AS (

&#x20;   SELECT

&#x20;       department,

&#x20;       COUNT(\*) AS employees

&#x20;   FROM employees

&#x20;   GROUP BY department

),



student\_stats AS (

&#x20;   SELECT

&#x20;       department,

&#x20;       COUNT(\*) AS students

&#x20;   FROM student\_scores

&#x20;   GROUP BY department

)



SELECT \*

FROM employee\_stats;

```



Multiple CTEs are separated by commas.



\---



\# ⛓️ Chained CTEs



One CTE can use another CTE that was defined before it.



```sql

WITH department\_average AS (

&#x20;   SELECT

&#x20;       department,

&#x20;       AVG(salary) AS average\_salary

&#x20;   FROM employees

&#x20;   GROUP BY department

),



high\_cost\_departments AS (

&#x20;   SELECT

&#x20;       department,

&#x20;       average\_salary

&#x20;   FROM department\_average

&#x20;   WHERE average\_salary >= 70000

)



SELECT \*

FROM high\_cost\_departments;

```



This creates a step-by-step SQL pipeline.



\---



\# 🆚 CTE vs Subquery



A nested subquery might look like:



```sql

SELECT \*

FROM (

&#x20;   SELECT

&#x20;       department,

&#x20;       AVG(salary) AS average\_salary

&#x20;   FROM employees

&#x20;   GROUP BY department

) AS department\_summary

WHERE average\_salary > 60000;

```



The same logic using a CTE:



```sql

WITH department\_summary AS (

&#x20;   SELECT

&#x20;       department,

&#x20;       AVG(salary) AS average\_salary

&#x20;   FROM employees

&#x20;   GROUP BY department

)

SELECT \*

FROM department\_summary

WHERE average\_salary > 60000;

```



The CTE version is often easier to read and maintain.



\---



\# ✅ Advantages of CTEs



CTEs can make SQL:



\- Easier to read

\- Easier to debug

\- Easier to maintain

\- More modular

\- Better organized

\- Easier to explain

\- Less dependent on deeply nested queries



They are especially useful in analytical SQL.



\---



\# ⚠️ Important Point



A CTE is not permanently stored.



It exists only while the statement executes.



After the query finishes, the CTE disappears.



It is different from a real table or permanent view.



\---



\# 💼 Real-World Applications



CTEs are commonly used for:



\- Department-level analysis

\- Customer segmentation

\- Sales summaries

\- Churn analytics

\- Employee performance reports

\- Data-cleaning pipelines

\- Multi-step calculations

\- ETL transformations

\- Financial analysis

\- Reporting queries

\- Dashboard preparation



\---



\# 💻 Practice



Today's exercises include:



\- Basic CTEs

\- Employee filtering

\- Salary analysis

\- Student performance summaries

\- Department statistics

\- CTE filtering

\- Joining CTEs to tables

\- Comparing rows with group averages

\- Multiple CTEs

\- Chained CTEs

\- Ranking departments by aggregated metrics

\- Data-quality summaries

\- Multi-step analytical reports



All practice queries are available in:



`queries.sql`



\---



\# 🎯 What I Learned



Today I learned how Common Table Expressions can divide complicated SQL queries into clear logical steps.



Using `WITH`, I can create temporary named datasets that make queries easier to understand and maintain.



I also learned how CTEs can contain filters and aggregate calculations, join with normal tables, and even reference earlier CTEs.



CTEs are an important foundation for advanced SQL topics because they allow complex analytics to be structured as readable pipelines instead of deeply nested statements.



\---



\## 📈 Challenge Progress



\*\*Day 18 / 30 ✅\*\*



Previous: \*\*Day 17 - Date \& Time Functions\*\*



Next: \*\*Day 19 - Window Functions: ROW\_NUMBER, RANK \& DENSE\_RANK\*\*

