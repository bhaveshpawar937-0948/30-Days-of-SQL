\# Day 29 - Constraints \& Advanced Data Integrity 🔐



Welcome to \*\*Day 29 of my 30 Days of SQL Challenge\*\*.



Today I explored \*\*SQL Constraints and Advanced Data Integrity in MySQL\*\*.



A database should not only store information. It should also ensure that the information remains accurate, consistent, and logically valid.



SQL constraints help enforce rules directly at the database level, preventing invalid records and protecting relationships between tables.



Today, I focused on advanced constraint management, composite uniqueness, foreign key actions, and maintaining referential integrity.



\---



\## 📚 Concepts Covered



\- Database constraints

\- Data integrity

\- Entity integrity

\- Domain integrity

\- Referential integrity

\- `NOT NULL`

\- `UNIQUE`

\- Composite `UNIQUE`

\- `PRIMARY KEY`

\- `FOREIGN KEY`

\- `CHECK`

\- `DEFAULT`

\- Named constraints

\- `ON DELETE CASCADE`

\- `ON DELETE RESTRICT`

\- `ON DELETE SET NULL`

\- `ON UPDATE CASCADE`

\- `ALTER TABLE ADD CONSTRAINT`

\- `ALTER TABLE DROP CHECK`

\- Constraint inspection

\- Constraint violations

\- Constraint design best practices



\---



\# 🧠 What Are SQL Constraints?



Constraints are rules enforced by a database to protect the quality and consistency of stored data.



For example, an employee database might require:



\- Every employee to have a unique ID

\- Every employee to have a name

\- Email addresses to be unique

\- Salaries to be non-negative

\- Departments to exist before employees reference them

\- Project budgets to be greater than zero



These rules can be enforced directly using SQL.



```text

Incoming Data

&#x20;     |

&#x20;     v

Database Constraints

&#x20;     |

&#x20;     +---- Valid Data ----> Stored

&#x20;     |

&#x20;     +---- Invalid Data --> Rejected

```



Constraints help protect the database even when multiple applications are inserting or updating records.



\---



\# 🧱 Types of Data Integrity



There are several important categories of data integrity.



\## 1. Entity Integrity



Entity integrity ensures that each row can be uniquely identified.



Example:



```sql

employee\_id INT PRIMARY KEY

```



A primary key cannot contain duplicate or NULL values.



\---



\## 2. Domain Integrity



Domain integrity ensures that values belong to an acceptable range or format.



Example:



```sql

salary DECIMAL(10,2)

CHECK (salary >= 0)

```



This prevents negative salaries.



\---



\## 3. Referential Integrity



Referential integrity ensures that relationships between tables remain valid.



Example:



```sql

FOREIGN KEY (department\_id)

REFERENCES departments(department\_id)

```



An employee cannot reference a department that does not exist, unless the foreign key permits NULL and the employee's department is NULL.



\---



\# 🔒 NOT NULL Constraint



The `NOT NULL` constraint prevents a column from storing NULL.



Example:



```sql

CREATE TABLE departments (

&#x20;   department\_id INT PRIMARY KEY,

&#x20;   department\_name VARCHAR(100) NOT NULL

);

```



This ensures every department has a name value.



However, `NOT NULL` alone does not prevent an empty string.



For stricter validation, it can be combined with a `CHECK` constraint.



\---



\# 🔑 UNIQUE Constraint



A `UNIQUE` constraint prevents duplicate values in a column or specified combination of columns.



Example:



```sql

CREATE TABLE users (

&#x20;   user\_id INT PRIMARY KEY,

&#x20;   email VARCHAR(100) NOT NULL,

&#x20;   CONSTRAINT uq\_user\_email UNIQUE (email)

);

```



The database rejects duplicate email values according to the column's comparison rules and collation.



\---



\# 🧩 Composite UNIQUE Constraint



A composite unique constraint enforces uniqueness across multiple columns.



Example:



```sql

CREATE TABLE projects (

&#x20;   project\_id INT PRIMARY KEY,

&#x20;   department\_id INT NOT NULL,

&#x20;   project\_code VARCHAR(20) NOT NULL,



&#x20;   CONSTRAINT uq\_department\_project

&#x20;       UNIQUE (department\_id, project\_code)

);

```



Consider:



| Department | Project Code | Allowed? |

|---|---|---|

| Engineering | API | Yes |

| Analytics | API | Yes |

| Engineering | API | No |

| Engineering | WEB | Yes |



The project code can be reused in another department.



However, the same department cannot use the same project code twice.



This is useful when identifiers need to be unique within a particular business group rather than globally.



\---



\# ✅ CHECK Constraint



The `CHECK` constraint validates values against a condition.



Example:



```sql

CREATE TABLE products (

&#x20;   product\_id INT PRIMARY KEY,

&#x20;   product\_name VARCHAR(100) NOT NULL,

&#x20;   price DECIMAL(10,2) NOT NULL,



&#x20;   CONSTRAINT chk\_product\_price

&#x20;       CHECK (price > 0)

);

```



A product cannot have a price of zero or less.



MySQL 8.0.16 and later enforce `CHECK` constraints.



\---



\# 🎯 Multiple CHECK Constraints



A table can have multiple validation rules.



Example:



```sql

CREATE TABLE employees (

&#x20;   employee\_id INT PRIMARY KEY,

&#x20;   employee\_name VARCHAR(100) NOT NULL,

&#x20;   salary DECIMAL(10,2) NOT NULL,

&#x20;   employment\_status VARCHAR(20) NOT NULL,



&#x20;   CONSTRAINT chk\_salary

&#x20;       CHECK (salary >= 0),



&#x20;   CONSTRAINT chk\_status

&#x20;       CHECK (

&#x20;           employment\_status IN (

&#x20;               'ACTIVE',

&#x20;               'LEAVE',

&#x20;               'EXITED'

&#x20;           )

&#x20;       )

);

```



This ensures that salaries and employment statuses follow defined rules.



\---



\# ⚠️ CHECK and NULL Values



An important detail is that a `CHECK` constraint does not automatically reject NULL.



For example:



```sql

CHECK (salary >= 0)

```



does not necessarily prevent a NULL salary because the expression evaluates to UNKNOWN.



To reject NULL, use:



```sql

salary DECIMAL(10,2) NOT NULL

```



together with:



```sql

CHECK (salary >= 0)

```



Both constraints serve different purposes.



\---



\# ⚙️ DEFAULT Constraint



A default value is automatically used when an inserted row omits a column.



Example:



```sql

employment\_status VARCHAR(20)

&#x20;   NOT NULL DEFAULT 'ACTIVE'

```



If no status is supplied, MySQL uses:



```text

ACTIVE

```



Defaults reduce repeated input and help maintain consistent initial values.



\---



\# 🔗 FOREIGN KEY Constraint



A foreign key establishes a relationship between tables.



Example:



```sql

CREATE TABLE employees (

&#x20;   employee\_id INT PRIMARY KEY,

&#x20;   employee\_name VARCHAR(100),

&#x20;   department\_id INT,



&#x20;   CONSTRAINT fk\_employee\_department

&#x20;       FOREIGN KEY (department\_id)

&#x20;       REFERENCES departments(department\_id)

);

```



The foreign key protects the relationship between employees and departments.



\---



\# 🔥 ON DELETE CASCADE



`ON DELETE CASCADE` automatically deletes related child records when the referenced parent record is deleted.



Example:



```sql

FOREIGN KEY (employee\_id)

REFERENCES employees(employee\_id)

ON DELETE CASCADE

```



Suppose:



```text

Employee 101

&#x20;   |

&#x20;   +---- Assignment A

&#x20;   |

&#x20;   +---- Assignment B

```



If Employee 101 is deleted:



```text

Employee 101 deleted

&#x20;       |

&#x20;       v

Assignment A deleted

Assignment B deleted

```



This is useful when child records should not exist independently of their parent.



However, cascading deletes must be designed carefully because they can remove multiple related records.



\---



\# 🛑 ON DELETE RESTRICT



`ON DELETE RESTRICT` prevents a parent record from being deleted while dependent child records exist.



Example:



```sql

FOREIGN KEY (department\_id)

REFERENCES departments(department\_id)

ON DELETE RESTRICT

```



Suppose a department owns an active project.



The database will prevent deleting that department until the dependent project is removed or reassigned.



This protects important business relationships.



\---



\# 🔄 ON DELETE SET NULL



`ON DELETE SET NULL` changes the child table's foreign key value to NULL when the parent record is deleted.



Example:



```sql

FOREIGN KEY (department\_id)

REFERENCES departments(department\_id)

ON DELETE SET NULL

```



Before deletion:



```text

Employee: Rahul

Department: Operations

```



After deleting the Operations department:



```text

Employee: Rahul

Department: NULL

```



The employee record remains available.



The foreign key column must allow NULL for this action.



\---



\# 🔁 ON UPDATE CASCADE



`ON UPDATE CASCADE` automatically updates related foreign key values when the referenced parent key changes.



Example:



```sql

FOREIGN KEY (department\_id)

REFERENCES departments(department\_id)

ON UPDATE CASCADE

```



Before:



```text

Department ID: 10

Employee Department ID: 10

```



After updating the parent department ID:



```text

Department ID: 11

Employee Department ID: 11

```



The relationship remains valid automatically.



\---



\# 🆚 Foreign Key Actions



| Action | Behavior |

|---|---|

| CASCADE | Automatically propagates deletion or key updates |

| RESTRICT | Prevents the parent operation when dependent rows exist |

| SET NULL | Replaces the child foreign key with NULL |

| NO ACTION | In MySQL InnoDB, behaves like RESTRICT |



Choosing the correct action depends on the business requirements.



For example:



\- Employee assignments may use `CASCADE`.

\- Active projects may require `RESTRICT`.

\- Optional employee-department relationships may use `SET NULL`.



\---



\# 🏷️ Named Constraints



Constraints can be assigned meaningful names.



Example:



```sql

CONSTRAINT chk\_employee\_salary

CHECK (salary >= 0)

```



Meaningful names make database errors easier to understand and simplify schema maintenance.



Compare:



```text

Constraint violation

```



with:



```text

chk\_employee\_salary violation

```



The second message provides much more useful information.



\---



\# 🛠️ ALTER TABLE ADD CONSTRAINT



Constraints can be added to an existing table.



Example:



```sql

ALTER TABLE employees

ADD CONSTRAINT chk\_employee\_salary

CHECK (salary >= 0);

```



MySQL validates existing rows when adding an enforced check constraint.



If existing data violates the rule, the operation fails.



\---



\# 🗑️ Removing a CHECK Constraint



MySQL allows named check constraints to be removed.



Example:



```sql

ALTER TABLE employees

DROP CHECK chk\_employee\_salary;

```



Removing a constraint changes the validation rules applied to future database operations.



Such changes should be carefully reviewed.



\---



\# 🔍 Inspecting Constraints



MySQL provides metadata about database constraints through `INFORMATION\_SCHEMA`.



Example:



```sql

SELECT

&#x20;   table\_name,

&#x20;   constraint\_name,

&#x20;   constraint\_type

FROM information\_schema.table\_constraints

WHERE table\_schema = DATABASE();

```



This helps identify:



\- Primary keys

\- Unique constraints

\- Foreign keys

\- Check constraints



\---



\# 🔎 Inspecting Foreign Key Rules



Foreign key actions can be inspected using:



```sql

SELECT

&#x20;   table\_name,

&#x20;   constraint\_name,

&#x20;   update\_rule,

&#x20;   delete\_rule

FROM information\_schema.referential\_constraints

WHERE constraint\_schema = DATABASE();

```



This is useful when auditing an unfamiliar database.



\---



\# 🧪 Constraint Violations



Suppose a salary must be non-negative.



This statement should fail:



```sql

INSERT INTO employees (

&#x20;   employee\_id,

&#x20;   employee\_name,

&#x20;   salary

)

VALUES (

&#x20;   101,

&#x20;   'Rahul',

&#x20;   -5000

);

```



The database rejects the row because it violates the salary constraint.



A constraint violation is not a successful insertion.



It is the database correctly protecting its integrity rules.



\---



\# ⚠️ Constraints vs Triggers



Both constraints and triggers can protect data, but they serve different purposes.



\## Constraints



Constraints enforce declarative rules.



Examples:



```text

Salary must be positive.

Email must be unique.

Department must exist.

```



\## Triggers



Triggers execute procedural logic when data changes.



Examples:



```text

Record salary changes.

Create audit entries.

Perform automatic logging.

```



For straightforward integrity rules, constraints are generally preferable because they clearly express the rule in the schema.



\---



\# 🏢 Real-World Database Example



Consider a company database with four tables:



```text

DEPARTMENTS

&#x20;    |

&#x20;    +------ EMPLOYEES

&#x20;    |            |

&#x20;    |            |

&#x20;    +------ PROJECTS

&#x20;                 |

&#x20;                 |

&#x20;             ASSIGNMENTS

&#x20;                 |

&#x20;                 +---- Employee

&#x20;                 +---- Project

```



Different constraints protect different relationships.



Examples:



\- Every department has a unique code.

\- Every employee has a unique email.

\- Salaries cannot be negative.

\- Projects must belong to existing departments.

\- Project budgets must be positive.

\- An employee cannot receive the same project assignment twice.

\- Deleting an employee removes their assignments.

\- Deleting a department with active projects is restricted.



Together, these rules help maintain reliable business data.



\---



\# 🧠 Advanced Constraint Design



Good constraint design requires understanding the relationships between tables.



Before creating constraints, ask:



1\. Can this column contain NULL?

2\. Must its value be unique?

3\. Is there an acceptable value range?

4\. Does it reference another table?

5\. What happens when the parent record is deleted?

6\. What happens when a referenced key changes?

7\. Should related child records remain available?

8\. Does the rule require one column or multiple columns?



These questions help prevent integrity problems before they occur.



\---



\# ⚠️ Important Limitations



Constraints cannot express every business rule.



For example, a standard MySQL `CHECK` constraint cannot directly validate an aggregate across multiple rows or query another table.



Such rules may require application logic, transactions, triggers, or other database mechanisms.



Also remember:



\- MySQL DDL statements can cause implicit commits.

\- Foreign keys require compatible column definitions.

\- InnoDB is the standard transactional storage engine supporting foreign keys.

\- `CASCADE` operations can affect multiple records.

\- `UNIQUE` constraints can permit multiple NULL values.

\- CHECK enforcement requires a supported MySQL version.



\---



\# 💼 Real-World Applications



Advanced constraints are essential for:



\- Banking databases

\- E-commerce platforms

\- Inventory systems

\- Employee management

\- Payroll systems

\- Student information systems

\- Healthcare databases

\- Financial applications

\- Order management

\- Data warehouses

\- ETL validation

\- Enterprise applications



\---



\# 💻 Practice



Today's exercises include:



\- Creating tables with multiple constraints

\- Defining named constraints

\- Implementing composite uniqueness

\- Validating salaries and budgets

\- Testing default values

\- Preventing invalid foreign keys

\- Using `ON DELETE CASCADE`

\- Using `ON DELETE RESTRICT`

\- Using `ON DELETE SET NULL`

\- Using `ON UPDATE CASCADE`

\- Adding constraints using `ALTER TABLE`

\- Removing check constraints

\- Inspecting database metadata

\- Testing constraint violations

\- Verifying referential integrity



All practice queries are available in:



`queries.sql`



The exercises use separate `d29\_` practice tables so that existing challenge tables remain unaffected.



\---



\# 🎯 What I Learned



Today I learned how SQL constraints protect database accuracy, consistency, and relationships.



I explored entity integrity, domain integrity, and referential integrity, along with the different constraints used to enforce these rules.



One of the most important concepts was composite uniqueness, which allows combinations of values to be unique without requiring every individual column to be unique.



I also learned how foreign key actions such as `CASCADE`, `RESTRICT`, and `SET NULL` control what happens when related records are modified or deleted.



Using `ALTER TABLE`, I practiced adding and removing named constraints.



Finally, I learned how to inspect database constraints through `INFORMATION\_SCHEMA`.



Reliable database systems depend not only on correctly written queries but also on well-designed rules that prevent invalid data from entering the database.



\---



\## 📈 Challenge Progress



\*\*Day 29 / 30 🔄 In Progress\*\*



Previous: \*\*Day 28 - Triggers \& Automated Database Actions\*\*



Next: \*\*Day 30 - Final SQL Capstone Project\*\*

