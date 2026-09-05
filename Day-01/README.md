# Day 01 — SQL & Database Fundamentals 🗄️

Welcome to **Day 01 of my 30 Days of SQL Challenge**.

Today I focused on understanding the foundations of relational databases and learned how SQL is used to create and manage structured data.

---

## 📚 Concepts Covered

* What is a Database?
* What is DBMS?
* What is RDBMS?
* What is SQL?
* Tables, Rows and Columns
* Primary Keys
* Creating a Database
* Creating Tables
* Viewing Table Structure

---

## 🧠 What is SQL?

**SQL (Structured Query Language)** is a language used to communicate with relational databases.

It allows us to:

* Create databases and tables
* Insert data
* Retrieve data
* Update existing records
* Delete records
* Filter and analyze data

SQL is widely used in data analytics, software development, data engineering and database management.

---

## 🗃️ DBMS vs RDBMS

### DBMS

A **Database Management System** is software used to store, manage and retrieve data.

### RDBMS

A **Relational Database Management System** stores data in structured tables that can be related to one another.

Examples include:

* MySQL
* PostgreSQL
* Microsoft SQL Server
* Oracle Database

---

## 📊 Understanding Tables

A relational database stores information using tables.

Example:

| student_id | name  | age | department              |
| ---------- | ----- | --: | ----------------------- |
| 1          | Rahul |  21 | Computer Science        |
| 2          | Priya |  20 | Artificial Intelligence |
| 3          | Aman  |  22 | Data Science            |

In this table:

* **Columns** represent attributes
* **Rows** represent individual records
* `student_id` can be used as a **Primary Key**

---

## 🔑 Primary Key

A primary key uniquely identifies each row in a table.

For example:

```sql
student_id INT PRIMARY KEY
```

Two students cannot have the same `student_id`.

---

## 💻 Practice

In today's SQL practice, I worked with:

* `CREATE DATABASE`
* `USE`
* `CREATE TABLE`
* `SHOW DATABASES`
* `SHOW TABLES`
* `DESCRIBE`

The queries are available in:

`queries.sql`

---

## 🎯 What I Learned

Today I understood how relational databases organize information and how SQL provides a structured way to interact with that information.

I also created my first database and table and learned how primary keys help uniquely identify records.

---

## 📈 Challenge Progress

**Day 01 / 30 ✅**

Next: **Day 02 — SELECT Statements & Data Retrieval**
