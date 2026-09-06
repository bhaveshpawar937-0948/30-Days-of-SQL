# Day 02 — SELECT Statements & Data Retrieval 🔎

Welcome to **Day 02 of my 30 Days of SQL Challenge**.

Today I focused on one of the most fundamental SQL operations: retrieving data from database tables using the `SELECT` statement.

---

## 📚 Concepts Covered

* `SELECT`
* `SELECT *`
* Selecting specific columns
* `DISTINCT`
* Column aliases using `AS`
* Retrieving calculated values
* Limiting result sets
* Basic data exploration

---

## 🧠 What is SELECT?

The `SELECT` statement is used to retrieve data from one or more columns in a database table.

Basic syntax:

```sql
SELECT column_name
FROM table_name;
```

To retrieve all columns:

```sql
SELECT *
FROM table_name;
```

---

## 📊 Selecting Specific Columns

Instead of retrieving every column, we can select only the information we need.

```sql
SELECT name, department
FROM students;
```

This makes queries easier to read and avoids retrieving unnecessary data.

---

## 🔁 DISTINCT

The `DISTINCT` keyword removes duplicate values from query results.

Example:

```sql
SELECT DISTINCT department
FROM students;
```

This returns each department only once.

---

## 🏷️ Column Aliases

Aliases allow us to give columns temporary names in the result.

```sql
SELECT name AS student_name
FROM students;
```

Aliases are useful when:

* Column names are unclear
* Calculations are performed
* Reports need readable headings

---

## 🧮 Calculated Columns

SQL can also perform calculations while retrieving data.

Example:

```sql
SELECT name, age, age + 1 AS age_next_year
FROM students;
```

This does not change the stored data. It only changes the displayed result.

---

## 💻 Practice

Today's exercises include:

* Retrieving all records
* Selecting specific columns
* Removing duplicates
* Renaming output columns
* Performing simple calculations
* Limiting query results

The SQL queries are available in:

`queries.sql`

---

## 🎯 What I Learned

Today I learned how to retrieve data efficiently using `SELECT`.

I also practiced selecting only required columns, removing duplicate values using `DISTINCT`, and improving query readability using aliases.

Understanding `SELECT` is essential because almost every SQL analysis begins by retrieving data from a database.

---

## 📈 Challenge Progress

**Day 02 / 30 ✅**

Previous: **Day 01 — SQL & Database Fundamentals**

Next: **Day 03 — Filtering Data with WHERE**
