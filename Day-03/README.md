# Day 03 — Filtering Data with WHERE 🔎

Welcome to **Day 03 of my 30 Days of SQL Challenge**.

Today I focused on filtering records using the `WHERE` clause and learned how to retrieve only the rows that match specific conditions.

---

## 📚 Concepts Covered

* `WHERE`
* Comparison operators
* `AND`
* `OR`
* `NOT`
* `BETWEEN`
* `IN`
* `LIKE`
* Wildcards
* Combining multiple conditions

---

## 🧠 What is the WHERE Clause?

The `WHERE` clause is used to filter records based on a condition.

Basic syntax:

```sql
SELECT column_name
FROM table_name
WHERE condition;
```

Example:

```sql
SELECT *
FROM students
WHERE age > 20;
```

This returns only students whose age is greater than 20.

---

## ⚖️ Comparison Operators

SQL provides several comparison operators for filtering data.

| Operator | Meaning                  |
| -------- | ------------------------ |
| `=`      | Equal to                 |
| `>`      | Greater than             |
| `<`      | Less than                |
| `>=`     | Greater than or equal to |
| `<=`     | Less than or equal to    |
| `<>`     | Not equal to             |

Example:

```sql
SELECT *
FROM students
WHERE age >= 21;
```

---

## 🔗 AND Operator

The `AND` operator is used when multiple conditions must all be true.

```sql
SELECT *
FROM students
WHERE age >= 21
AND city = 'Mumbai';
```

Both conditions must be satisfied.

---

## 🔀 OR Operator

The `OR` operator returns rows where at least one condition is true.

```sql
SELECT *
FROM students
WHERE city = 'Mumbai'
OR city = 'Pune';
```

---

## 🚫 NOT Operator

The `NOT` operator excludes records matching a condition.

```sql
SELECT *
FROM students
WHERE NOT city = 'Mumbai';
```

---

## ↔️ BETWEEN

`BETWEEN` is used to filter values within a range.

```sql
SELECT *
FROM students
WHERE age BETWEEN 20 AND 22;
```

The boundary values are included.

---

## 📦 IN

The `IN` operator allows us to match a value against multiple possible options.

```sql
SELECT *
FROM students
WHERE city IN ('Mumbai', 'Pune');
```

This is cleaner than writing multiple `OR` conditions.

---

## 🔤 LIKE

The `LIKE` operator is used for pattern matching.

Common wildcards:

* `%` matches any number of characters
* `_` matches exactly one character

Example:

```sql
SELECT *
FROM students
WHERE name LIKE 'R%';
```

This finds names starting with `R`.

---

## 💻 Practice

Today's exercises include:

* Filtering records by age
* Filtering students by city
* Combining conditions using `AND` and `OR`
* Excluding records using `NOT`
* Filtering ranges with `BETWEEN`
* Using `IN` for multiple values
* Searching text patterns with `LIKE`

The SQL queries are available in:

`queries.sql`

---

## 🎯 What I Learned

Today I learned how to control which rows are returned from a database using conditional filtering.

The `WHERE` clause makes SQL much more powerful because it allows queries to focus only on relevant records instead of retrieving the entire table.

I also learned how logical operators and pattern matching can be combined to build more precise queries.

---

## 📈 Challenge Progress

**Day 03 / 30 ✅**

Previous: **Day 02 — SELECT Statements & Data Retrieval**

Next: **Day 04 — Sorting Data with ORDER BY & LIMIT**
