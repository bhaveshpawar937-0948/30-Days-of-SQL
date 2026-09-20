\# Day 13 - Correlated Subqueries, EXISTS \& NOT EXISTS 🔍



Welcome to \*\*Day 13 of my 30 Days of SQL Challenge\*\*.



Today I focused on \*\*correlated subqueries\*\* and the `EXISTS` / `NOT EXISTS` operators.



Unlike a regular subquery, a correlated subquery refers to values from the outer query. This means the inner query is evaluated in relation to each row being processed by the outer query.



These techniques are especially useful when checking whether related records exist.



\---



\## 📚 Concepts Covered



\* Correlated subqueries

\* Outer query references

\* `EXISTS`

\* `NOT EXISTS`

\* Relationship checks

\* Row-by-row comparison

\* Employees compared with department averages

\* Students with related records

\* Students without related records

\* Comparing correlated subqueries with regular subqueries



\---



\## 🧠 What is a Correlated Subquery?



A correlated subquery depends on the current row of the outer query.



Example:



```sql

SELECT

&#x20;   e.employee\_name,

&#x20;   e.department,

&#x20;   e.salary

FROM employees AS e

WHERE e.salary > (

&#x20;   SELECT AVG(e2.salary)

&#x20;   FROM employees AS e2

&#x20;   WHERE e2.department = e.department

);

```



The inner query uses:



```sql

e.department

```



from the outer query.



This means the department average is calculated separately for each employee's department.



\---



\## 🔄 Regular vs Correlated Subquery



A regular subquery can usually execute independently.



```sql

SELECT AVG(salary)

FROM employees;

```



A correlated subquery depends on the outer query:



```sql

SELECT AVG(e2.salary)

FROM employees AS e2

WHERE e2.department = e.department;

```



The value of `e.department` changes as the outer query processes different rows.



\---



\## ✅ EXISTS



`EXISTS` checks whether a subquery returns at least one row.



Example:



```sql

SELECT

&#x20;   s.student\_id,

&#x20;   s.name

FROM students AS s

WHERE EXISTS (

&#x20;   SELECT 1

&#x20;   FROM student\_projects AS p

&#x20;   WHERE p.student\_id = s.student\_id

);

```



This returns students who have at least one matching project record.



\---



\## 🚫 NOT EXISTS



`NOT EXISTS` performs the opposite check.



```sql

SELECT

&#x20;   s.student\_id,

&#x20;   s.name

FROM students AS s

WHERE NOT EXISTS (

&#x20;   SELECT 1

&#x20;   FROM student\_projects AS p

&#x20;   WHERE p.student\_id = s.student\_id

);

```



This returns students who do not have a project.



\---



\## ❓ Why SELECT 1?



Inside `EXISTS`, SQL only checks whether a matching row exists.



The selected value itself does not matter.



Therefore this is common:



```sql

SELECT 1

```



The database is essentially being asked:



> Does at least one matching row exist?



\---



\## 📊 Department-Level Comparison



Correlated subqueries are very useful when comparing one row against its own group.



Example:



```sql

SELECT

&#x20;   employee\_name,

&#x20;   department,

&#x20;   salary

FROM employees AS e

WHERE salary > (

&#x20;   SELECT AVG(e2.salary)

&#x20;   FROM employees AS e2

&#x20;   WHERE e2.department = e.department

);

```



Each employee is compared against the average salary of their own department.



\---



\## 💡 Where These Concepts Are Useful



Correlated subqueries and `EXISTS` are useful for:



\* Finding customers with orders

\* Finding customers without orders

\* Identifying employees above their department average

\* Finding products that have been sold

\* Finding unused products

\* Checking relationship existence

\* Identifying missing related records

\* Detecting parent-child relationships



\---



\## 💻 Practice



Today's exercises include:



\* Employees earning above their department average

\* Employees earning below their department average

\* Highest-paid employee within each department

\* Students with project assignments

\* Students without project assignments

\* Departments containing high-performing students

\* Managers with direct reports

\* Employees with no subordinates

\* Project relationship checks

\* Correlated comparisons across grouped data



The complete SQL practice is available in:



`queries.sql`



\---



\## 🎯 What I Learned



Today I learned how correlated subqueries can use data from the outer query to perform row-specific calculations and checks.



I also learned how `EXISTS` and `NOT EXISTS` can efficiently test whether related records are present.



These techniques are especially useful when solving relationship-based analytical problems and identifying missing or existing associations between records.



\---



\## 📈 Challenge Progress



\*\*Day 13 / 30 ✅\*\*



Previous: \*\*Day 12 - Subqueries\*\*



Next: \*\*Day 14 - CASE Expressions \& Conditional Logic\*\*



