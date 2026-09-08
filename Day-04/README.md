# Day 04 — Sorting & Limiting Data with ORDER BY and LIMIT 📊

Welcome to **Day 04 of my 30 Days of SQL Challenge**.

Today I focused on controlling the order of query results using `ORDER BY` and limiting the number of returned rows using `LIMIT`.

These concepts are especially useful when working with large datasets, rankings, top-performing records, recent entries, and sorted reports.

---

## 📚 Concepts Covered

* `ORDER BY`
* Ascending order using `ASC`
* Descending order using `DESC`
* Sorting by multiple columns
* Sorting text and numeric values
* Combining `WHERE` with `ORDER BY`
* `LIMIT`
* `OFFSET`
* Retrieving Top-N records

---

## 🧠 What is ORDER BY?

The `ORDER BY` clause is used to sort query results.

By default, SQL sorts values in ascending order.

Basic syntax:

```sql
SELECT column_name
FROM table_name
ORDER BY column_name;
```

Example:

```sql
SELECT *
FROM students
ORDER BY age;
```

This sorts students from youngest to oldest.

---

## ⬆️ ASC — Ascending Order

`ASC` sorts values from smallest to largest.

For text, it sorts alphabetically from A to Z.

```sql
SELECT *
FROM students
ORDER BY name ASC;
```

---

## ⬇️ DESC — Descending Order

`DESC` sorts values from largest to smallest.

For text, it sorts alphabetically from Z to A.

```sql
SELECT *
FROM students
ORDER BY age DESC;
```

---

## 🔀 Sorting by Multiple Columns

SQL can sort results using more than one column.

Example:

```sql
SELECT *
FROM students
ORDER BY department ASC, age DESC;
```

This first sorts students by department and then sorts students within each department by age.

---

## 🎯 Combining WHERE and ORDER BY

Filtering and sorting can be used together.

```sql
SELECT *
FROM students
WHERE age >= 21
ORDER BY age DESC;
```

This first filters the students and then sorts the remaining rows.

---

## 🔢 LIMIT

The `LIMIT` clause controls how many rows are returned.

Example:

```sql
SELECT *
FROM students
LIMIT 3;
```

Only the first three records are returned.

---

## 🏆 Top-N Queries

`ORDER BY` and `LIMIT` are often combined to find the highest or lowest values.

Example:

```sql
SELECT *
FROM students
ORDER BY age DESC
LIMIT 3;
```

This returns the three oldest students.

---

## ⏭️ OFFSET

`OFFSET` can be used with `LIMIT` to skip a number of rows.

Example:

```sql
SELECT *
FROM students
ORDER BY student_id
LIMIT 2 OFFSET 2;
```

This skips the first two rows and returns the next two.

This technique is commonly used in pagination.

---

## 💻 Practice

Today's exercises include:

* Sorting by age
* Sorting alphabetically
* Ascending and descending order
* Sorting by multiple columns
* Combining filtering with sorting
* Returning Top-N records
* Using `LIMIT`
* Using `OFFSET`
* Creating simple ranking-style queries

The SQL queries are available in:

`queries.sql`

---

## 🎯 What I Learned

Today I learned how to control the presentation of query results using `ORDER BY`.

I also learned how `LIMIT` can be used to return only the most relevant records and how combining `ORDER BY` with `LIMIT` can help identify top-performing or highest-value records.

These concepts are especially useful in analytics, reporting, dashboards, and ranking queries.

---

## 📈 Challenge Progress

**Day 04 / 30 ✅**

Previous: **Day 03 — Filtering Data with WHERE**

Next: **Day 05 — Aggregate Functions**
