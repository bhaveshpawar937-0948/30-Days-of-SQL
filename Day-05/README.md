# Day 05 - Aggregate Functions 📊

Welcome to **Day 05 of my 30 Days of SQL Challenge**.

Today I focused on SQL aggregate functions, which are used to summarize multiple rows of data and return useful numerical insights.

Aggregate functions are extremely important in **data analysis, reporting, dashboards, and business intelligence** because they allow large datasets to be converted into meaningful summary statistics.

---

## 📚 Concepts Covered

* `COUNT()`
* `SUM()`
* `AVG()`
* `MIN()`
* `MAX()`
* Aggregate functions with `WHERE`
* `COUNT(DISTINCT ...)`
* Aliases with aggregate functions
* Working with numerical data
* Basic analytical queries

---

## 🧠 What Are Aggregate Functions?

Aggregate functions perform calculations across multiple rows and return a summarized result.

For example:

```sql
SELECT AVG(score)
FROM student_scores;
```

Instead of returning every student's score, this query calculates the average score across all students.

---

## 🔢 COUNT()

`COUNT()` is used to count records.

```sql
SELECT COUNT(*)
FROM student_scores;
```

This returns the total number of rows in the table.

We can also count values from a specific column:

```sql
SELECT COUNT(score)
FROM student_scores;
```

---

## ➕ SUM()

`SUM()` calculates the total of a numerical column.

```sql
SELECT SUM(score)
FROM student_scores;
```

This returns the combined total of all student scores.

---

## 📈 AVG()

`AVG()` calculates the average value of a numerical column.

```sql
SELECT AVG(score)
FROM student_scores;
```

This is commonly used when analyzing:

* Average salary
* Average sales
* Average marks
* Average customer spending
* Average product prices

---

## 🔽 MIN()

`MIN()` returns the smallest value.

```sql
SELECT MIN(score)
FROM student_scores;
```

This identifies the lowest score in the dataset.

---

## 🔼 MAX()

`MAX()` returns the largest value.

```sql
SELECT MAX(score)
FROM student_scores;
```

This identifies the highest score.

---

## 🎯 Aggregate Functions with WHERE

Aggregate functions can be combined with filtering.

Example:

```sql
SELECT AVG(score)
FROM student_scores
WHERE department = 'Data Science';
```

This calculates the average score only for Data Science students.

---

## 🔁 COUNT with DISTINCT

`DISTINCT` can be used with `COUNT()` to count unique values.

```sql
SELECT COUNT(DISTINCT department)
FROM student_scores;
```

This returns the number of unique departments.

---

## 🏷️ Using Aliases

Aliases make analytical results easier to understand.

```sql
SELECT AVG(score) AS average_score
FROM student_scores;
```

Instead of displaying something such as:

`AVG(score)`

the result column will appear as:

`average_score`

---

## 📊 Multiple Aggregate Functions

Several aggregate functions can be used in the same query.

```sql
SELECT
    COUNT(*) AS total_students,
    AVG(score) AS average_score,
    MIN(score) AS lowest_score,
    MAX(score) AS highest_score
FROM student_scores;
```

This provides a compact statistical summary of the dataset.

---

## 💻 Practice

Today's exercises include:

* Counting records
* Counting unique values
* Calculating totals
* Finding averages
* Finding minimum values
* Finding maximum values
* Filtering before aggregation
* Combining multiple aggregate functions
* Creating readable output using aliases

The complete SQL practice is available in:

`queries.sql`

---

## 🎯 What I Learned

Today I learned how SQL can summarize large amounts of data using aggregate functions.

Instead of retrieving individual rows, functions such as `COUNT()`, `SUM()`, `AVG()`, `MIN()`, and `MAX()` allow us to answer analytical questions about an entire dataset.

These functions form an important foundation for SQL-based data analysis and will become even more powerful when combined with `GROUP BY` in the next part of the challenge.

---

## 📈 Challenge Progress

**Day 05 / 30 ✅**

Previous: **Day 04 - Sorting & Limiting Data**

Next: **Day 06 - GROUP BY and HAVING**
