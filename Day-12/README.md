\# Day 12 - SQL Subqueries 🧠



Welcome to \*\*Day 12 of my 30 Days of SQL Challenge\*\*.



Today I explored \*\*subqueries\*\*, which allow one SQL query to be nested inside another query.



Subqueries are useful when the result of one query is needed as an input or condition for another query.



They make it possible to solve analytical problems such as:



\* Finding employees earning above the company average

\* Finding students scoring above the average score

\* Comparing values against calculated results

\* Finding records belonging to specific groups

\* Using one query to filter another query



\---



\## 📚 Concepts Covered



\* Subqueries

\* Inner query and outer query

\* Scalar subqueries

\* Subqueries with `WHERE`

\* Subqueries with comparison operators

\* Subqueries with `IN`

\* Subqueries with `NOT IN`

\* Subqueries inside `SELECT`

\* Subqueries inside `FROM`

\* Derived tables

\* Nested analytical queries



\---



\## 🧠 What is a Subquery?



A subquery is a SQL query written inside another SQL query.



Example:



```sql

SELECT

&#x20;   student\_name,

&#x20;   score

FROM student\_scores

WHERE score > (

&#x20;   SELECT AVG(score)

&#x20;   FROM student\_scores

);

```



The inner query:



```sql

SELECT AVG(score)

FROM student\_scores;

```



calculates the average score.



The outer query then finds students whose score is greater than that average.



\---



\## 🔄 Inner Query vs Outer Query



A subquery generally contains two logical parts.



```text

Outer Query

&#x20;   ↓

Uses the result of

&#x20;   ↓

Inner Query

```



Example:



```sql

SELECT employee\_name

FROM employees

WHERE salary > (

&#x20;   SELECT AVG(salary)

&#x20;   FROM employees

);

```



The database first determines the average salary and then uses that value to evaluate the outer query.



\---



\## 1️⃣ Scalar Subquery



A scalar subquery returns exactly \*\*one value\*\*.



Example:



```sql

SELECT

&#x20;   employee\_name,

&#x20;   salary

FROM employees

WHERE salary > (

&#x20;   SELECT AVG(salary)

&#x20;   FROM employees

);

```



Since `AVG()` produces one value, the inner query is a scalar subquery.



\---



\## 📦 Subquery with IN



When a subquery returns multiple values, `IN` can be used.



Example:



```sql

SELECT

&#x20;   name,

&#x20;   department

FROM students

WHERE department IN (

&#x20;   SELECT department

&#x20;   FROM student\_scores

&#x20;   WHERE score >= 90

);

```



The inner query may return several departments.



The outer query checks whether each student's department belongs to that result.



\---



\## 🚫 Subquery with NOT IN



`NOT IN` can be used to exclude values returned by another query.



```sql

SELECT

&#x20;   name

FROM students

WHERE student\_id NOT IN (

&#x20;   SELECT student\_id

&#x20;   FROM student\_projects

);

```



This can be used to find students who do not appear in the project table.



\---



\## 📊 Subquery Inside SELECT



A subquery can also calculate information displayed alongside every row.



```sql

SELECT

&#x20;   employee\_name,

&#x20;   salary,

&#x20;   (

&#x20;       SELECT AVG(salary)

&#x20;       FROM employees

&#x20;   ) AS company\_average\_salary

FROM employees;

```



This makes it easy to compare each record against an overall benchmark.



\---



\## 🗃️ Subquery Inside FROM



A query can also be treated as a temporary result set.



Example:



```sql

SELECT \*

FROM (

&#x20;   SELECT

&#x20;       department,

&#x20;       AVG(score) AS average\_score

&#x20;   FROM student\_scores

&#x20;   GROUP BY department

) AS department\_summary;

```



The inner query creates a temporary dataset.



The outer query then works with that result.



This is called a \*\*derived table\*\*.



\---



\## 💡 Why Subqueries Matter



Subqueries are useful when:



\* A filtering condition depends on a calculated value

\* A query depends on another query's result

\* A temporary analytical dataset is needed

\* Data needs to be compared against averages or maximum values

\* Related records need to be included or excluded

\* A complex problem needs to be divided into smaller logical steps



\---



\## 💻 Practice



Today's exercises include:



\* Finding scores above average

\* Finding highest-scoring students

\* Finding employees earning above average

\* Comparing salaries against department-level values

\* Using `IN` with multi-row subqueries

\* Using `NOT IN`

\* Displaying calculated benchmarks

\* Creating derived tables

\* Filtering aggregated subquery results

\* Solving multi-step analytical questions



All practice queries are available in:



`queries.sql`



\---



\## 🎯 What I Learned



Today I learned how to use the output of one SQL query inside another query.



Subqueries make analytical SQL more flexible because calculated results can be used dynamically rather than manually entering fixed values.



I also learned that subqueries can appear in several parts of a statement, including `WHER



