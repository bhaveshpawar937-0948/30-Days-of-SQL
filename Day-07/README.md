\# Day 07 - LEFT JOIN \& Unmatched Records 🔗



Welcome to \*\*Day 08 of my 30 Days of SQL Challenge\*\*.



Today I focused on the `LEFT JOIN`, which allows us to combine related tables while keeping every record from the left table, even when no matching record exists in the right table.



This is especially useful when looking for missing relationships in data, such as customers who never placed an order, students without projects, or employees without assigned departments.



\---



\## 📚 Concepts Covered



\* `LEFT JOIN`

\* Left and right tables

\* Matching records between tables

\* Unmatched records

\* `NULL` values produced by joins

\* Finding records with no relationship

\* Table aliases

\* Anti-join pattern using `IS NULL`



\---



\## 🧠 What is a LEFT JOIN?



A `LEFT JOIN` returns every row from the table written on the left side of the join.



If a matching record exists in the right table, SQL returns the related data.



If no matching record exists, the columns from the right table contain `NULL`.



Basic syntax:



```sql

SELECT

&#x20;   a.column\_name,

&#x20;   b.column\_name

FROM table\_a AS a

LEFT JOIN table\_b AS b

&#x20;   ON a.id = b.id;

```



\---



\## 🔗 Example



Suppose we have a `students` table and a `student\_projects` table.



```sql

SELECT

&#x20;   s.name,

&#x20;   p.project\_name

FROM students AS s

LEFT JOIN student\_projects AS p

&#x20;   ON s.student\_id = p.student\_id;

```



Every student will appear in the result.



Students who do not have a project will have:



```text

NULL

```



in the `project\_name` column.



\---



\## 🆚 INNER JOIN vs LEFT JOIN



An `INNER JOIN` returns only records that have a match in both tables.



A `LEFT JOIN` keeps every row from the left table.



Conceptually:



```text

INNER JOIN

Students WITH matching projects only



LEFT JOIN

ALL students

\+

matching project information when available

```



\---



\## 🔍 Finding Unmatched Records



One of the most useful `LEFT JOIN` patterns is finding records without a match.



```sql

SELECT

&#x20;   s.student\_id,

&#x20;   s.name

FROM students AS s

LEFT JOIN student\_projects AS p

&#x20;   ON s.student\_id = p.student\_id

WHERE p.project\_id IS NULL;

```



This returns students who have not been assigned a project.



This pattern is commonly known as an \*\*anti-join pattern\*\*.



\---



\## 💡 Why LEFT JOIN Matters in Analytics



`LEFT JOIN` is useful for identifying:



\* Customers who never placed an order

\* Products that were never sold

\* Students without assigned projects

\* Employees without managers

\* Users who did not complete an activity

\* Records with missing relationships



This makes it especially useful for data quality checks and business analysis.



\---



\## 💻 Practice



Today's exercises include:



\* Joining students with project information

\* Keeping all students in the result

\* Displaying project details where available

\* Detecting `NULL` values created by unmatched joins

\* Finding students without projects

\* Finding students with projects

\* Using aliases for cleaner relational queries

\* Creating an anti-join query



The complete practice queries are available in:



`queries.sql`



\---



\## 🎯 What I Learned



Today I learned that joins are not only useful for combining matching records.



`LEFT JOIN` can preserve the full population from one table while showing related information when it exists.



I also learned how `NULL` values created by a `LEFT JOIN` can be used to identify missing relationships in a dataset.



This is a useful SQL technique for analytics, reporting, data validation, and business problem solving.



\---



\## 📈 Challenge Progress



\*\*Day 08 / 30 ✅\*\*



Previous: \*\*Day 07 - INNER JOIN\*\*



Next: \*\*Day 09 - RIGHT JOIN \& Join Direction\*\*



