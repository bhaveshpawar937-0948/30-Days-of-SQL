\# Day 08 - RIGHT JOIN \& Join Direction 🔗



Welcome to \*\*Day 08 of my 30 Days of SQL Challenge\*\*.



Today I focused on the `RIGHT JOIN` and learned how the direction of a join affects which table's records are preserved.



While a `LEFT JOIN` keeps every record from the left table, a `RIGHT JOIN` keeps every record from the table written on the right side of the query.



\---



\## 📚 Concepts Covered



\* `RIGHT JOIN`

\* Left table vs right table

\* Preserving all records from the right table

\* Matching and unmatched records

\* `NULL` values created by unmatched joins

\* Finding missing relationships

\* Reversing join direction

\* Table aliases

\* Understanding equivalent join logic



\---



\## 🧠 What is a RIGHT JOIN?



A `RIGHT JOIN` returns:



\* Every row from the right table

\* Matching rows from the left table

\* `NULL` for left-table columns when no match exists



Basic syntax:



```sql

SELECT

&#x20;   a.column\_name,

&#x20;   b.column\_name

FROM table\_a AS a

RIGHT JOIN table\_b AS b

&#x20;   ON a.id = b.id;

```



The important idea is:



```text

RIGHT JOIN → preserve the RIGHT table

```



\---



\## 🔗 Example



Using the `student\_projects` and `students` tables:



```sql

SELECT

&#x20;   s.name,

&#x20;   p.project\_name

FROM student\_projects AS p

RIGHT JOIN students AS s

&#x20;   ON p.student\_id = s.student\_id;

```



Because `students` is on the right side, \*\*every student appears in the result\*\*.



Students without an assigned project will have:



```text

NULL

```



for the project columns.



\---



\## ↔️ Join Direction



The order of tables matters when using outer joins.



This:



```sql

FROM student\_projects AS p

RIGHT JOIN students AS s

```



preserves all students.



The same logical result can often be written by reversing the tables and using a `LEFT JOIN`.



Understanding this relationship helps make complex joins easier to read.



\---



\## 🔍 Finding Unmatched Right-Side Records



A `RIGHT JOIN` can help identify records from the right table that have no matching row in the left table.



Example:



```sql

SELECT

&#x20;   s.student\_id,

&#x20;   s.name

FROM student\_projects AS p

RIGHT JOIN students AS s

&#x20;   ON p.student\_id = s.student\_id

WHERE p.project\_id IS NULL;

```



This returns students who do not have a project assignment.



\---



\## 💡 Why Join Direction Matters



Join direction becomes important when deciding which dataset must remain complete.



Examples include:



\* Keeping every customer even if they have no orders

\* Keeping every student even if they have no project

\* Keeping every employee even if they have no assigned task

\* Keeping every product even if it has never been sold



Choosing the correct preserved table is an important part of relational querying.



\---



\## 💻 Practice



Today's exercises include:



\* Preserving all students using a `RIGHT JOIN`

\* Displaying matching project information

\* Identifying unmatched records

\* Detecting `NULL` values created by joins

\* Reversing table order

\* Comparing logically equivalent outer joins

\* Building student-project reports

\* Understanding which table controls the result set



The complete SQL practice is available in:



`queries.sql`



\---



\## 🎯 What I Learned



Today I learned that join direction affects which table remains complete in the result.



`RIGHT JOIN` preserves every record from the right-side table while returning matching information from the left-side table when available.



I also learned that many `RIGHT JOIN` queries can be rewritten using `LEFT JOIN` by reversing the order of the tables.



Understanding this relationship makes SQL joins easier to reason about and helps avoid accidentally dropping important records.



\---



\## 📈 Challenge Progress



\*\*Day 08 / 30 ✅\*\*



Previous: \*\*Day 07 - LEFT JOIN \& Unmatched Records\*\*



Next: \*\*Day 09 - SELF JOIN\*\*



