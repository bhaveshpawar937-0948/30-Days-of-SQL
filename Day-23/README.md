\# Day 23 - Views \& Reusable SQL Queries 👁️



Welcome to \*\*Day 23 of my 30 Days of SQL Challenge\*\*.



Today I explored \*\*SQL Views\*\*, which allow us to save a query as a reusable virtual table.



A view does not usually store a separate copy of the data. Instead, it stores the SQL definition and returns fresh results from the underlying tables whenever it is queried.



Views are extremely useful for simplifying complex SQL, creating reusable reporting layers, hiding unnecessary columns, standardizing business logic, and making analytical queries easier to maintain.



\---



\## 📚 Concepts Covered



\- `CREATE VIEW`

\- Querying a view

\- `CREATE OR REPLACE VIEW`

\- `DROP VIEW`

\- Views based on filters

\- Views based on joins

\- Views based on aggregates

\- Views with calculated columns

\- Reusable reporting queries

\- Simplifying complex SQL

\- Data abstraction

\- Security-oriented column exposure

\- Limitations of views

\- Views vs tables

\- Views vs CTEs



\---



\# 🧠 What is a View?



A view is a named SQL query that behaves like a virtual table.



Basic syntax:



```sql

CREATE VIEW view\_name AS

SELECT ...

FROM ...;

```



Example:



```sql

CREATE VIEW high\_salary\_employees AS



SELECT

&#x20;   employee\_id,

&#x20;   employee\_name,

&#x20;   department,

&#x20;   salary



FROM employees



WHERE salary >= 70000;

```



Once created, it can be queried like a normal table:



```sql

SELECT \*

FROM high\_salary\_employees;

```



\---



\# 👁️ Why Use Views?



Without a view, a complex query might need to be written again and again.



For example:



```sql

SELECT

&#x20;   employee\_name,

&#x20;   department,

&#x20;   salary

FROM employees

WHERE salary >= 70000;

```



Instead, we can save it once:



```sql

CREATE VIEW high\_salary\_employees AS

...

```



and later use:



```sql

SELECT \*

FROM high\_salary\_employees;

```



This improves readability and reuse.



\---



\# 🧱 Views Are Virtual Tables



A regular table stores data.



A view usually stores:



```text

The SQL query definition

```



not a separate physical copy of the results.



Conceptually:



```text

View

&#x20; ↓

Stored Query

&#x20; ↓

Underlying Tables

&#x20; ↓

Current Results

```



If the underlying table changes, the view result can reflect those changes automatically.



\---



\# 🔍 Filtered Views



Views can save commonly used filters.



Example:



```sql

CREATE VIEW engineering\_employees AS



SELECT

&#x20;   employee\_id,

&#x20;   employee\_name,

&#x20;   job\_role,

&#x20;   salary



FROM employees



WHERE department = 'Engineering';

```



Now:



```sql

SELECT \*

FROM engineering\_employees;

```



returns only Engineering employees.



\---



\# 🔗 Views with JOINs



A view can contain joins.



```sql

CREATE VIEW employee\_manager\_view AS



SELECT

&#x20;   e.employee\_name,

&#x20;   e.department,

&#x20;   e.job\_role,



&#x20;   COALESCE(

&#x20;       m.employee\_name,

&#x20;       'No Manager'

&#x20;   ) AS manager\_name



FROM employees AS e



LEFT JOIN employees AS m

&#x20;   ON e.manager\_id = m.employee\_id;

```



This hides the join complexity from future queries.



\---



\# 📊 Aggregate Views



Views can also contain aggregates.



```sql

CREATE VIEW department\_salary\_summary AS



SELECT

&#x20;   department,

&#x20;   COUNT(\*) AS employee\_count,

&#x20;   ROUND(AVG(salary), 2) AS average\_salary,

&#x20;   MIN(salary) AS minimum\_salary,

&#x20;   MAX(salary) AS maximum\_salary



FROM employees



GROUP BY department;

```



Then:



```sql

SELECT \*

FROM department\_salary\_summary;

```



can be used directly in reporting.



\---



\# 🧮 Views with Calculated Columns



A view can expose calculated values.



```sql

CREATE VIEW employee\_salary\_categories AS



SELECT

&#x20;   employee\_name,

&#x20;   department,

&#x20;   salary,



&#x20;   CASE

&#x20;       WHEN salary >= 80000 THEN 'High Salary'

&#x20;       WHEN salary >= 60000 THEN 'Medium Salary'

&#x20;       ELSE 'Entry Salary'

&#x20;   END AS salary\_category



FROM employees;

```



This allows the classification logic to be defined in one place.



\---



\# 🔄 CREATE OR REPLACE VIEW



If a view already exists, its definition can be replaced.



```sql

CREATE OR REPLACE VIEW high\_salary\_employees AS



SELECT

&#x20;   employee\_id,

&#x20;   employee\_name,

&#x20;   department,

&#x20;   job\_role,

&#x20;   salary



FROM employees



WHERE salary >= 75000;

```



This updates the saved query definition.



\---



\# 🗑️ DROP VIEW



A view can be removed using:



```sql

DROP VIEW view\_name;

```



Safer version:



```sql

DROP VIEW IF EXISTS view\_name;

```



Dropping a view does not delete the underlying table data.



\---



\# 🛡️ Views for Data Exposure



Suppose an employee table contains sensitive or unnecessary columns.



Instead of giving users access to:



```text

employee\_id

employee\_name

department

salary

manager\_id

...

```



we could expose:



```sql

CREATE VIEW public\_employee\_directory AS



SELECT

&#x20;   employee\_name,

&#x20;   department,

&#x20;   job\_role



FROM employees;

```



Users querying the view only see the selected columns.



Views can therefore help create controlled data-access layers.



\---



\# 🆚 View vs Table



| Feature | Table | View |

|---|---|---|

| Stores data | Yes | Usually no |

| Stores query logic | No | Yes |

| Can be queried | Yes | Yes |

| Can simplify joins | No | Yes |

| Reflects source changes | N/A | Yes |

| Used as reusable layer | Sometimes | Very common |



\---



\# 🆚 View vs CTE



A CTE exists only for one statement:



```sql

WITH employee\_data AS (...)

SELECT ...

```



A view remains available in the database until it is removed.



```text

CTE

→ Temporary for one query



VIEW

→ Reusable database object

```



This is one of the biggest differences between the two.



\---



\# 📌 Views Can Be Queried Further



A view is not the end of the query.



For example:



```sql

SELECT \*

FROM department\_salary\_summary



WHERE average\_salary > 70000



ORDER BY average\_salary DESC;

```



This means a reusable summary can be filtered differently for different reports.



\---



\# ⚠️ View Limitations



Views are powerful, but there are important considerations:



\- Complex views can become difficult to maintain

\- Some views are not directly updatable

\- Performance still depends on the underlying query

\- A view does not automatically make a slow query faster

\- Changes to underlying table structures may affect views

\- Too many layers of nested views can make debugging difficult



Views should simplify SQL, not hide unnecessary complexity.



\---



\# 💼 Real-World Applications



Views are commonly used for:



\- Dashboard datasets

\- Reusable reports

\- BI tools

\- Data-access layers

\- Hiding sensitive columns

\- Standardizing business rules

\- Employee reports

\- Sales summaries

\- Customer analytics

\- Data engineering pipelines

\- Data marts

\- Simplifying complex joins



\---



\# 💻 Practice



Today's exercises include:



\- Creating simple views

\- Creating filtered views

\- Querying views

\- Creating aggregate views

\- Creating join-based views

\- Creating calculated-column views

\- Salary summary views

\- Student performance views

\- Project assignment views

\- Manager hierarchy views

\- Replacing view definitions

\- Filtering data from views

\- Creating dashboard-ready views

\- Dropping views safely



All practice queries are available in:



`queries.sql`



\---



\# 🎯 What I Learned



Today I learned how SQL views can turn commonly used queries into reusable database objects.



Views allow complex filters, joins, aggregates, and calculated columns to be defined once and queried many times.



I also learned how views differ from tables and CTEs, and how they can be used to build cleaner reporting and analytics layers.



Views are especially valuable in real-world analytics because they help standardize logic and make complex database structures easier for downstream users and BI tools to work with.



\---



\## 📈 Challenge Progress



\*\*Day 23 / 30 ✅

