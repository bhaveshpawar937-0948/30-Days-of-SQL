\# Day 22 - NTILE, PERCENT\_RANK \& CUME\_DIST 📊



Welcome to \*\*Day 22 of my 30 Days of SQL Challenge\*\*.



Today I explored \*\*distribution window functions\*\*, which help analyze where a row sits relative to other rows in a dataset.



The three main functions covered today are:



\- `NTILE()`

\- `PERCENT\_RANK()`

\- `CUME\_DIST()`



Unlike the ranking functions from Day 19, today's functions focus on \*\*distribution, segmentation, and relative position\*\*.



These techniques are useful for customer segmentation, salary analysis, student performance bands, percentile analysis, and business intelligence.



\---



\## 📚 Concepts Covered



\- Distribution window functions

\- `NTILE()`

\- Quartiles

\- Deciles

\- `PERCENT\_RANK()`

\- `CUME\_DIST()`

\- Relative position

\- Percentile-style analysis

\- `PARTITION BY`

\- Distribution within groups

\- Customer segmentation

\- Salary bands

\- Student performance bands

\- CTEs with distribution functions



\---



\# 🧠 What Are Distribution Window Functions?



Distribution window functions describe where a row is positioned compared with other rows.



Suppose employee salaries are sorted from lowest to highest.



Instead of simply assigning:



```text

1

2

3

4

5

```



we may want to know:



```text

Which salary quartile is this employee in?



What percentage of employees are below this employee?



What proportion of employees have salaries less than or equal to this salary?

```



Distribution functions help answer these questions.



\---



\# 🪣 NTILE()



`NTILE()` divides an ordered result set into a specified number of groups.



Basic syntax:



```sql

NTILE(number\_of\_groups) OVER (

&#x20;   ORDER BY column

)

```



Example:



```sql

SELECT

&#x20;   employee\_name,

&#x20;   salary,



&#x20;   NTILE(4) OVER (

&#x20;       ORDER BY salary

&#x20;   ) AS salary\_quartile



FROM employees;

```



`NTILE(4)` divides employees into approximately four equally sized groups.



\---



\# 📦 Understanding Quartiles



Using:



```sql

NTILE(4)

```



creates:



```text

Quartile 1

Quartile 2

Quartile 3

Quartile 4

```



When salaries are ordered ascending:



```text

Q1 → Lower salary range

Q2 → Lower-middle range

Q3 → Upper-middle range

Q4 → Higher salary range

```



This is useful for salary and customer-value segmentation.



\---



\# 🔟 Deciles



We are not limited to four groups.



```sql

NTILE(10) OVER (

&#x20;   ORDER BY salary

)

```



divides rows into approximately ten groups.



These groups are called \*\*deciles\*\*.



\---



\# 🎯 Custom Segmentation



We can create other segment sizes too.



```sql

NTILE(3)

```



creates three groups.



```sql

NTILE(5)

```



creates five groups.



This makes `NTILE()` useful for business segmentation.



\---



\# 🏢 NTILE Within Departments



`PARTITION BY` can restart the segmentation for each department.



```sql

NTILE(4) OVER (

&#x20;   PARTITION BY department

&#x20;   ORDER BY salary

)

```



Now every department receives its own salary quartiles.



\---



\# 📈 PERCENT\_RANK()



`PERCENT\_RANK()` calculates the relative rank of a row between `0` and `1`.



Example:



```sql

SELECT

&#x20;   employee\_name,

&#x20;   salary,



&#x20;   PERCENT\_RANK() OVER (

&#x20;       ORDER BY salary

&#x20;   ) AS salary\_percent\_rank



FROM employees;

```



The lowest-ranked row normally receives:



```text

0

```



while the highest-ranked row approaches or reaches:



```text

1

```



\---



\# 🧮 PERCENT\_RANK Formula



Conceptually:



```text

RANK - 1

──────────────

Total Rows - 1

```



For example, if a row has rank `4` among `10` rows:



```text

(4 - 1) / (10 - 1)



3 / 9



0.3333

```



So its percent rank is approximately:



```text

33.33%

```



\---



\# 💯 Convert PERCENT\_RANK to Percentage



We can make the result easier to read:



```sql

ROUND(

&#x20;   PERCENT\_RANK() OVER (

&#x20;       ORDER BY salary

&#x20;   ) \* 100,

&#x20;   2

)

```



Possible result:



```text

0.00

11.11

22.22

33.33

...

100.00

```



\---



\# 🌊 CUME\_DIST()



`CUME\_DIST()` means \*\*cumulative distribution\*\*.



It calculates the proportion of rows whose value is less than or equal to the current row's value when sorting ascending.



Example:



```sql

SELECT

&#x20;   employee\_name,

&#x20;   salary,



&#x20;   CUME\_DIST() OVER (

&#x20;       ORDER BY salary

&#x20;   ) AS salary\_distribution



FROM employees;

```



The result ranges above `0` and up to:



```text

1

```



\---



\# 🧮 CUME\_DIST Concept



Conceptually:



```text

Rows with value <= current value

───────────────────────────────

Total number of rows

```



If 7 out of 10 employees have a salary less than or equal to the current employee:



```text

7 / 10 = 0.70

```



The cumulative distribution is:



```text

70%

```



\---



\# ⚔️ PERCENT\_RANK vs CUME\_DIST



Although they look similar, they answer different questions.



| Function | Main Question |

|---|---|

| `PERCENT\_RANK()` | Where does this row rank relative to the others? |

| `CUME\_DIST()` | What proportion of rows are at or below this value? |



The difference becomes especially noticeable when duplicate values exist.



\---



\# 🧩 NTILE vs Ranking Functions



`RANK()` gives positions:



```text

1

2

2

4

5

```



`NTILE(4)` creates groups:



```text

1

1

2

3

4

```



Therefore:



```text

RANK → Position



NTILE → Segment

```



\---



\# 💼 Customer Segmentation



Suppose a table contains customer spending.



We could write:



```sql

NTILE(4) OVER (

&#x20;   ORDER BY total\_spending

)

```



Then convert the quartiles into labels:



```sql

CASE

&#x20;   WHEN spending\_quartile = 4

&#x20;       THEN 'High Value'



&#x20;   WHEN spending\_quartile = 3

&#x20;       THEN 'Upper Medium'



&#x20;   WHEN spending\_quartile = 2

&#x20;       THEN 'Lower Medium'



&#x20;   ELSE 'Low Value'

END

```



This is a common analytical technique.



\---



\# 🎓 Student Performance Bands



Students can also be divided into performance groups.



```sql

NTILE(4) OVER (

&#x20;   ORDER BY score DESC

)

```



This could represent:



```text

1 → Top performers

2 → Above average

3 → Developing

4 → Needs improvement

```



\---



\# 🏢 Distribution Within Groups



Distribution functions can use `PARTITION BY`.



Example:



```sql

PERCENT\_RANK() OVER (

&#x20;   PARTITION BY department

&#x20;   ORDER BY salary

)

```



Now an employee's position is calculated relative only to coworkers in the same department.



\---



\# 🧱 Using CTEs for Segmentation



A CTE makes segmentation easier to label.



```sql

WITH salary\_segments AS (

&#x20;   SELECT

&#x20;       employee\_name,

&#x20;       salary,



&#x20;       NTILE(4) OVER (

&#x20;           ORDER BY salary

&#x20;       ) AS salary\_quartile



&#x20;   FROM employees

)



SELECT

&#x20;   employee\_name,

&#x20;   salary,

&#x20;   salary\_quartile,



&#x20;   CASE

&#x20;       WHEN salary\_quartile = 4

&#x20;           THEN 'High'



&#x20;       WHEN salary\_quartile = 3

&#x20;           THEN 'Upper Medium'



&#x20;       WHEN salary\_quartile = 2

&#x20;           THEN 'Lower Medium'



&#x20;       ELSE 'Low'

&#x20;   END AS salary\_segment



FROM salary\_segments;

```



This converts numerical distribution groups into business-friendly categories.



\---



\# ⚠️ Important NTILE Detail



`NTILE()` attempts to distribute rows as evenly as possible.



If the number of rows cannot be divided perfectly, some buckets will contain one additional row.



For example:



```text

10 rows

÷

4 buckets

```



might produce bucket sizes such as:



```text

3

3

2

2

```



\---



\# 💼 Real-World Applications



Distribution window functions are commonly used for:



\- Customer segmentation

\- Salary benchmarking

\- Student performance bands

\- Sales representative segmentation

\- Product performance analysis

\- Credit-risk segmentation

\- Customer lifetime value analysis

\- Marketing targeting

\- Revenue segmentation

\- Percentile reporting

\- Performance dashboards

\- Business intelligence



\---



\# 💻 Practice



Today's exercises include:



\- Salary quartiles

\- Salary deciles

\- Department quartiles

\- Student performance quartiles

\- Percent ranks

\- Cumulative distributions

\- Department-level distributions

\- Percentage conversion

\- Customer-style segmentation

\- Salary-band labeling

\- Top percentile identification

\- Bottom percentile identification

\- Distribution summaries

\- CTE-based segmentation

\- Combined distribution analytics



All practice queries are available in:



`queries.sql`



\---



\# 🎯 What I Learned



Today I learned how SQL distribution window functions can describe a row's position within an entire dataset or within a specific group.



`NTILE()` divides rows into approximately equal buckets, making it useful for quartiles, deciles, and business segmentation.



`PERCENT\_RANK()` measures relative ranking between 0 and 1, while `CUME\_DIST()` measures the proportion of rows at or below the current value.



I also learned how these functions can be combined with `PARTITION BY`, CTEs, and `CASE` expressions to create practical salary bands and performance segments.



These techniques are extremely useful for analytics because they transform raw numerical values into meaningful relative positions and business categories.



\---



\## 📈 Challenge Progress



\*\*Day 22 / 30 ✅\*\*



Previous: \*\*Day 21 - LAG, LEAD, FIRST\_VALUE \& LAST\_VALUE\*\*



Next: \*\*Day 23 - Views \& Reusable SQL Queries\*\*

