\# Day 14 - CASE Expressions \& Conditional Logic 🧠



Welcome to \*\*Day 14 of my 30 Days of SQL Challenge\*\*.



Today I explored the SQL `CASE` expression, which allows conditional logic to be added directly inside SQL queries.



`CASE` works similarly to `if / elif / else` logic in programming languages such as Python.



It can transform raw values into meaningful business categories without modifying the original data.



\---



\## 📚 Concepts Covered



\- `CASE`

\- `WHEN`

\- `THEN`

\- `ELSE`

\- `END`

\- Searched CASE expressions

\- Simple CASE expressions

\- Multiple conditions

\- CASE with `AND` / `OR`

\- CASE inside `SELECT`

\- CASE with aggregate functions

\- Conditional aggregation

\- Custom sorting using CASE

\- Business-rule classification



\---



\## 🧠 Basic CASE Syntax



```sql

CASE

&#x20;   WHEN condition THEN result

&#x20;   WHEN condition THEN result

&#x20;   ELSE result

END

```



Example:



```sql

SELECT

&#x20;   employee\_name,

&#x20;   salary,

&#x20;   CASE

&#x20;       WHEN salary >= 80000 THEN 'High Salary'

&#x20;       WHEN salary >= 60000 THEN 'Medium Salary'

&#x20;       ELSE 'Entry Salary'

&#x20;   END AS salary\_category

FROM employees;

```



SQL evaluates the conditions from top to bottom.



The first matching condition determines the result.



\---



\## 🐍 CASE vs Python Conditions



The idea is similar to:



```python

if salary >= 80000:

&#x20;   category = "High Salary"

elif salary >= 60000:

&#x20;   category = "Medium Salary"

else:

&#x20;   category = "Entry Salary"

```



SQL expresses the same logic using `CASE`.



\---



\## 1️⃣ Searched CASE



A searched `CASE` evaluates complete conditions.



```sql

CASE

&#x20;   WHEN score >= 90 THEN 'Excellent'

&#x20;   WHEN score >= 75 THEN 'Good'

&#x20;   WHEN score >= 60 THEN 'Average'

&#x20;   ELSE 'Needs Improvement'

END

```



This form is especially useful for ranges.



\---



\## 2️⃣ Simple CASE



A simple `CASE` compares one expression against specific values.



```sql

CASE department

&#x20;   WHEN 'Engineering' THEN 'Technical'

&#x20;   WHEN 'Analytics' THEN 'Data'

&#x20;   WHEN 'Management' THEN 'Leadership'

&#x20;   ELSE 'Other'

END

```



This works well when checking exact values.



\---



\## ⚠️ Condition Order Matters



Consider:



```sql

CASE

&#x20;   WHEN score >= 60 THEN 'Pass'

&#x20;   WHEN score >= 90 THEN 'Excellent'

END

```



A score of `95` already satisfies:



```text

score >= 60

```



so SQL never reaches the second condition.



A better order is:



```sql

CASE

&#x20;   WHEN score >= 90 THEN 'Excellent'

&#x20;   WHEN score >= 60 THEN 'Pass'

&#x20;   ELSE 'Fail'

END

```



Always place more specific or higher-threshold conditions first.



\---



\## 🔗 Multiple Conditions



`CASE` can use normal Boolean operators.



```sql

CASE

&#x20;   WHEN salary >= 70000

&#x20;        AND department = 'Engineering'

&#x20;   THEN 'Senior Technical'



&#x20;   WHEN salary >= 70000

&#x20;   THEN 'Senior'



&#x20;   ELSE 'Standard'

END

```



This allows business rules to become much more expressive.



\---



\## 📊 Conditional Aggregation



One of the most useful applications of `CASE` is combining it with aggregate functions.



Example:



```sql

SELECT

&#x20;   department,

&#x20;   COUNT(

&#x20;       CASE

&#x20;           WHEN salary >= 70000 THEN 1

&#x20;       END

&#x20;   ) AS high\_salary\_employees

FROM employees

GROUP BY department;

```



Another common pattern is:



```sql

SUM(

&#x20;   CASE

&#x20;       WHEN salary >= 70000 THEN 1

&#x20;       ELSE 0

&#x20;   END

)

```



This lets SQL count records that satisfy particular conditions.



\---



\## 🧮 CASE with SUM



Example:



```sql

SELECT

&#x20;   SUM(

&#x20;       CASE

&#x20;           WHEN department = 'Engineering'

&#x20;           THEN salary

&#x20;           ELSE 0

&#x20;       END

&#x20;   ) AS engineering\_payroll

FROM employees;

```



This performs aggregation only for rows matching a condition.



\---



\## 🔀 Custom Sorting



`CASE` can also control sorting.



```sql

ORDER BY

&#x20;   CASE department

&#x20;       WHEN 'Management' THEN 1

&#x20;       WHEN 'Engineering' THEN 2

&#x20;       WHEN 'Analytics' THEN 3

&#x20;       ELSE 4

&#x20;   END;

```



Instead of alphabetical sorting, we can define our own business priority.



\---



\## 💼 Real-World Uses



`CASE` is commonly used for:



\- Customer segmentation

\- Risk classification

\- Salary bands

\- Performance ratings

\- Churn-risk categories

\- Loan categories

\- Product price bands

\- Order status reporting

\- KPI calculations

\- Dashboard labels

\- Conditional aggregation

\- Custom report ordering



\---



\## 📌 Example: Churn Risk Logic



A churn analytics system could use:



```sql

CASE

&#x20;   WHEN churn\_probability >= 0.70 THEN 'High Risk'

&#x20;   WHEN churn\_probability >= 0.40 THEN 'Medium Risk'

&#x20;   ELSE 'Low Risk'

END AS risk\_level

```



This converts numerical model output into understandable business categories.



\---



\## 💻 Practice



Today's exercises include:



\- Salary classification

\- Student performance grading

\- Department categorization

\- Employee seniority labels

\- Multi-condition classifications

\- Conditional employee counts

\- Conditional salary totals

\- Department-specific aggregations

\- Custom sorting

\- Management classification

\- Business reporting rules



All queries are available in:



`queries.sql`



\---



\## 🎯 What I Learned



Today I learned how SQL can perform conditional decision-making using `CASE`.



Instead of only retrieving existing values, SQL can dynamically transform raw data into categories and business-friendly labels.



I also learned how `CASE` becomes especially powerful when combined with aggregate functions such as `COUNT`, `SUM`, and `AVG`.



Conditional aggregation makes it possible to calculate multiple business metrics within a single query.



\---



\## 📈 Challenge Progress



\*\*Day 14 / 30 ✅\*\*



Previous: \*\*Day 13 - Correlated Subqueries, EXISTS \& NOT EXISTS\*\*



Next: \*\*Day 15 - NULL Handling: COALESCE, NULLIF \& IFNULL\*\*

