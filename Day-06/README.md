# Day 06 - GROUP BY & HAVING 📊

Welcome to **Day 06 of my 30 Days of SQL Challenge**.

Today I focused on grouping records using `GROUP BY` and filtering grouped results using `HAVING`.

These concepts are essential in data analysis because they allow us to answer questions such as:

* Which department has the highest average score?
* How many students belong to each city?
* Which departments have more than two students?
* Which groups have an average score above a specific threshold?

---

## 📚 Concepts Covered

* `GROUP BY`
* Grouping by a single column
* Grouping by multiple columns
* Aggregations within groups
* `HAVING`
* Difference between `WHERE` and `HAVING`
* Combining `WHERE`, `GROUP BY`, `HAVING`, and `ORDER BY`
* Ranking grouped analytical results

---

## 🧠 GROUP BY

`GROUP BY` combines rows that contain the same value into groups.

Example:

```sql
SELECT department, COUNT(*) AS total_students
FROM student_scores
GROUP BY department;
```

Instead of returning one row for every student, this produces one result for each department.

---

## 📊 Aggregating Groups

Aggregate functions become much more useful when combined with `GROUP BY`.

```sql
SELECT
    department,
    AVG(score) AS average_score
FROM student_scores
GROUP BY department;
```

This calculates a separate average for each department.

---

## 🧩 Grouping by Multiple Columns

SQL can group data using more than one column.

```sql
SELECT
    department,
    city,
    COUNT(*) AS total_students
FROM student_scores
GROUP BY department, city;
```

Each unique combination of department and city becomes its own group.

---

## 🎯 HAVING

`HAVING` filters results **after grouping has occurred**.

Example:

```sql
SELECT
    department,
    AVG(score) AS average_score
FROM student_scores
GROUP BY department
HAVING AVG(score) > 85;
```

Only departments whose average score is greater than 85 are returned.

---

## ⚖️ WHERE vs HAVING

`WHERE` and `HAVING` perform different jobs.

### WHERE

Filters individual rows **before** grouping.

```sql
SELECT
    department,
    AVG(score) AS average_score
FROM student_scores
WHERE score >= 80
GROUP BY department;
```

### HAVING

Filters groups **after** aggregation.

```sql
SELECT
    department,
    AVG(score) AS average_score
FROM student_scores
GROUP BY department
HAVING AVG(score) >= 80;
```

A useful way to remember the difference:

```text
WHERE  → filters rows
HAVING → filters groups
```

---

## 🔄 Query Flow

A grouped analytical query commonly follows this structure:

```sql
SELECT
    group_column,
    aggregate_function(column)
FROM table_name
WHERE row_condition
GROUP BY group_column
HAVING group_condition
ORDER BY aggregate_result;
```

Conceptually:

```text
FROM
  ↓
WHERE
  ↓
GROUP BY
  ↓
HAVING
  ↓
SELECT
  ↓
ORDER BY
```

---

## 💻 Practice

Today's SQL exercises focus on:

* Student count by department
* Average score by department
* Performance by city
* Department and city combinations
* Filtering rows before grouping
* Filtering groups using `HAVING`
* Applying multiple `HAVING` conditions
* Ranking grouped results
* Combining the complete analytical query workflow

All queries are available in:

`queries.sql`

---

## 🎯 What I Learned

Today I learned how SQL can transform individual records into meaningful grouped summaries.

`GROUP BY` makes it possible to analyze categories such as departments, cities, products, customers, or regions rather than inspecting records individually.

I also learned that `WHERE` and `HAVING` operate at different stages of a query: `WHERE` filters individual records, while `HAVING` filters aggregated groups.

This combination is extremely useful for reporting, dashboards, business intelligence, and data analysis.

---

## 📈 Challenge Progress

**Day 06 / 30 ✅**

Previous: **Day 05 - Aggregate Functions**

Next: **Day 07 - INNER JOIN**
