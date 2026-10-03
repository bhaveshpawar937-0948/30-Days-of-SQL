\# Day 24 - Indexes \& Query Optimization ⚡



Welcome to \*\*Day 24 of my 30 Days of SQL Challenge\*\*.



Today I explored \*\*SQL indexes and query optimization\*\*.



As databases grow, writing a query that produces the correct result is only part of the job. The query should also retrieve that result efficiently.



Indexes help the database locate rows without repeatedly scanning every row in a table.



I also explored `EXPLAIN`, which helps inspect how MySQL plans to execute a query.



\---



\## 📚 Concepts Covered



\- Database indexes

\- `CREATE INDEX`

\- Single-column indexes

\- Composite indexes

\- Unique indexes

\- `SHOW INDEX`

\- `DROP INDEX`

\- `EXPLAIN`

\- Full table scans

\- Index lookups

\- Composite-index column order

\- The leftmost-prefix principle

\- Covering indexes

\- Sargable predicates

\- Query optimization

\- Index selectivity

\- Index trade-offs



\---



\# 🧠 What is an Index?



An index is a database structure designed to make data retrieval faster.



Without an appropriate index, MySQL may need to inspect many or all rows in a table.



Conceptually:



```text

Without Index



Table

&#x20;↓

Row 1

Row 2

Row 3

...

Row 100000

```



With an appropriate index:



```text

Index

&#x20; ↓

Matching location

&#x20; ↓

Required row(s)

```



An index works somewhat like the index of a textbook: it provides a faster route to relevant information.



\---



\# ⚡ Creating an Index



Basic syntax:



```sql

CREATE INDEX index\_name

ON table\_name(column\_name);

```



Example:



```sql

CREATE INDEX idx\_employee\_department

ON employees(department);

```



This can help queries that frequently search employees by department.



\---



\# 🔍 Query That Can Benefit From an Index



```sql

SELECT

&#x20;   employee\_id,

&#x20;   employee\_name,

&#x20;   department

FROM employees

WHERE department = 'Engineering';

```



If `department` is indexed, MySQL may use the index instead of scanning the entire table.



The optimizer ultimately decides whether using the index is worthwhile.



\---



\# 🔎 Viewing Existing Indexes



MySQL provides:



```sql

SHOW INDEX FROM employees;

```



This displays information such as:



\- Index name

\- Indexed columns

\- Column sequence

\- Uniqueness

\- Cardinality



\---



\# 🧩 Composite Indexes



A composite index contains multiple columns.



Example:



```sql

CREATE INDEX idx\_department\_salary

ON employees(department, salary);

```



This can be useful for queries such as:



```sql

SELECT \*

FROM employees

WHERE department = 'Engineering'

&#x20; AND salary >= 70000;

```



\---



\# 🧭 Column Order Matters



For this index:



```sql

(department, salary)

```



queries beginning with the leading indexed column are generally the natural matches.



For example:



```sql

WHERE department = 'Engineering'

```



can benefit from the index.



So can:



```sql

WHERE department = 'Engineering'

AND salary >= 70000

```



But a query using only:



```sql

WHERE salary >= 70000

```



cannot generally use the composite index as effectively for locating rows because `department` is the leftmost column.



This behavior is commonly called the \*\*leftmost-prefix principle\*\*.



\---



\# 🔐 Unique Indexes



A unique index improves lookup capabilities while also enforcing uniqueness.



Example:



```sql

CREATE UNIQUE INDEX idx\_unique\_employee\_email

ON employees(email);

```



Now duplicate indexed email values cannot normally be inserted.



Unique indexes therefore serve two purposes:



```text

Performance

\+

Data integrity

```



\---



\# 🧪 EXPLAIN



`EXPLAIN` shows how MySQL plans to execute a query.



Example:



```sql

EXPLAIN

SELECT \*

FROM employees

WHERE department = 'Engineering';

```



Important fields commonly include:



\- `type`

\- `possible\_keys`

\- `key`

\- `rows`

\- `Extra`



\---



\# 🔑 possible\_keys



`possible\_keys` shows indexes MySQL considers potentially useful.



\---



\# 🗝️ key



`key` shows the index MySQL actually chooses.



If the value is `NULL`, an index was not selected for that access path.



\---



\# 📊 rows



`rows` represents the optimizer's estimate of how many rows may need to be examined.



It is an estimate, not necessarily the exact number processed at runtime.



\---



\# 🚦 Understanding Access Types



The `type` field provides useful information about table access.



Common values include:



```text

ALL

index

range

ref

eq\_ref

const

```



`ALL` commonly indicates a full table scan.



Access such as `ref`, `range`, or `const` can indicate more selective access, depending on the query.



Optimization should always be judged in context rather than by chasing one particular `type`.



\---



\# 📖 Covering Indexes



Sometimes an index contains all columns required by a query.



Suppose we create:



```sql

CREATE INDEX idx\_department\_name\_salary

ON employees(

&#x20;   department,

&#x20;   employee\_name,

&#x20;   salary

);

```



A query such as:



```sql

SELECT

&#x20;   employee\_name,

&#x20;   salary

FROM employees

WHERE department = 'Engineering';

```



may be answered using only the index.



`EXPLAIN` may show:



```text

Using index

```



This is commonly known as a \*\*covering index\*\*.



\---



\# 🎯 Sargable Queries



A predicate is often called \*\*sargable\*\* when the database can effectively use an index to search for matching values.



Example:



```sql

WHERE salary >= 70000

```



With an index on `salary`, this can support an efficient range lookup.



\---



\# ⚠️ Functions on Indexed Columns



Suppose `hire\_date` is indexed.



This query:



```sql

WHERE YEAR(hire\_date) = 2026

```



applies a function to the indexed column and can make ordinary index lookup less effective.



A range predicate is often better:



```sql

WHERE hire\_date >= '2026-01-01'

&#x20; AND hire\_date < '2027-01-01'

```



This allows the database to search a date range directly.



\---



\# ⚠️ Avoid Unnecessary SELECT \*



Instead of:



```sql

SELECT \*

FROM employees

WHERE department = 'Engineering';

```



retrieve only required columns:



```sql

SELECT

&#x20;   employee\_id,

&#x20;   employee\_name,

&#x20;   salary

FROM employees

WHERE department = 'Engineering';

```



This can reduce unnecessary data transfer and can sometimes make covering-index strategies possible.



\---



\# 🎯 Index Selectivity



Indexes tend to be particularly useful when a condition narrows a large table to a relatively small number of rows.



For example, an index on a nearly unique email address is often highly selective.



A column containing only a few repeated values may be much less selective.



The optimizer considers factors like these when deciding whether to use an index.



\---



\# 🐢 Why Not Index Every Column?



Indexes are not free.



They require:



\- Additional storage

\- Extra work during `INSERT`

\- Extra work during `UPDATE`

\- Extra work during `DELETE`

\- Maintenance by the database engine



Too many indexes can therefore hurt write performance.



The goal is not:



```text

Maximum number of indexes

```



The goal is:



```text

Useful indexes for real query patterns

```



\---



\# 🗑️ Removing an Index



MySQL syntax:



```sql

DROP INDEX index\_name

ON table\_name;

```



Example:



```sql

DROP INDEX idx\_employee\_department

ON employees;

```



This removes the index without deleting the table itself.



\---



\# 🧠 Query Optimization Workflow



A practical workflow is:



```text

1\. Identify an important or slow query

&#x20;       ↓

2\. Inspect it with EXPLAIN

&#x20;       ↓

3\. Check filters, joins and sorting

&#x20;       ↓

4\. Design an appropriate index

&#x20;       ↓

5\. Run EXPLAIN again

&#x20;       ↓

6\. Measure real performance

```



Indexes should be created because they support actual workloads, not simply because a column exists.



\---



\# 💼 Real-World Applications



Indexes and query optimization are essential for:



\- Large analytical databases

\- Customer search systems

\- E-commerce applications

\- Banking systems

\- Reporting platforms

\- BI dashboards

\- APIs

\- Transaction systems

\- Data warehouses

\- Data engineering pipelines



\---



\# ⚠️ Important Lesson



A query can be:



```text

Correct

```



but still be:



```text

Slow

```



Good SQL development considers both correctness and efficiency.



\---



\# 💻 Practice



Today's exercises include:



\- Inspecting existing indexes

\- Creating single-column indexes

\- Creating composite indexes

\- Creating unique indexes

\- Using `EXPLAIN`

\- Comparing query plans

\- Testing equality lookups

\- Testing range lookups

\- Exploring composite-index order

\- Creating covering indexes

\- Rewriting non-sargable predicates

\- Optimizing join columns

\- Removing test indexes



All practice queries are available in:



`queries.sql`



\---



\# 🎯 What I Learned



Today I learned how indexes help databases locate information efficiently and how `EXPLAIN` can reveal the optimizer's execution strategy.



I learned the difference between single-column, composite, unique, and covering indexes.



I also learned why column order matters in composite indexes and how the leftmost-prefix principle affects which queries can efficiently use them.



Another important lesson was that functions applied directly to indexed columns can make index usage more difficult, while range-based predicates are often more index-friendly.



Finally, I learned that indexes have a cost. They improve many read operations but require storage and additional maintenance during writes.



Query optimization is therefore about choosing the right indexes and query structures for the workload rather than indexing everything.



\---



\## 📈 Challenge Progress



\*\*Day 24 / 30 ✅\*\*



Previous: \*\*Day 23 - Views \& Reusable SQL Queries\*\*



Next: \*\*Day 25 - Transactions, COMMIT, ROLLBACK \& SAVEPOINT\*\*

