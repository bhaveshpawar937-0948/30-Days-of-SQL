\# Day 28 - Triggers \& Automated Database Actions ⚡



Welcome to \*\*Day 28 of my 30 Days of SQL Challenge\*\*.



Today I explored \*\*SQL Triggers in MySQL\*\*.



A trigger is a database object that automatically executes when a specific event happens on a table.



Instead of manually running extra SQL every time data changes, triggers can react automatically to:



\- `INSERT`

\- `UPDATE`

\- `DELETE`



Triggers are useful for audit logging, automatic timestamps, validation, change tracking, and maintaining related data.



\---



\## 📚 Concepts Covered



\- SQL triggers

\- `CREATE TRIGGER`

\- `DROP TRIGGER`

\- `BEFORE INSERT`

\- `AFTER INSERT`

\- `BEFORE UPDATE`

\- `AFTER UPDATE`

\- `BEFORE DELETE`

\- `AFTER DELETE`

\- `NEW`

\- `OLD`

\- Audit tables

\- Automatic logging

\- Data validation

\- Automatic value modification

\- Trigger conditions

\- Change tracking

\- Trigger limitations



\---



\# 🧠 What is a Trigger?



A trigger is SQL logic that runs automatically when a defined event occurs.



Basic idea:



```text

Table Event

&#x20;  ↓

INSERT / UPDATE / DELETE

&#x20;  ↓

Trigger Executes Automatically

&#x20;  ↓

Additional Database Action

```



Unlike a stored procedure, a trigger is not executed manually with `CALL`.



The database activates it automatically.



\---



\# ⚡ Basic Trigger Syntax



Example:



```sql

DELIMITER //



CREATE TRIGGER trigger\_name

AFTER INSERT

ON employees

FOR EACH ROW



BEGIN



&#x20;   -- automatic SQL logic



END //



DELIMITER ;

```



The trigger executes once for every affected row.



\---



\# 🕒 BEFORE vs AFTER



Triggers can execute before or after an event.



\## BEFORE



Runs before the database change occurs.



Examples:



```text

BEFORE INSERT

BEFORE UPDATE

BEFORE DELETE

```



These are useful for:



\- Validation

\- Adjusting incoming values

\- Preventing invalid data



\---



\## AFTER



Runs after the change has succeeded.



Examples:



```text

AFTER INSERT

AFTER UPDATE

AFTER DELETE

```



These are commonly useful for:



\- Audit logs

\- History tables

\- Change tracking



\---



\# 🆕 NEW



`NEW` represents the new row values.



Example:



```sql

NEW.employee\_name

```



Inside an `INSERT` trigger:



```sql

NEW.salary

```



refers to the salary being inserted.



Inside an `UPDATE` trigger, `NEW.salary` represents the updated salary.



\---



\# 🕰️ OLD



`OLD` represents the previous row values.



Example:



```sql

OLD.salary

```



Inside an `UPDATE` trigger, it represents the salary before the update.



Inside a `DELETE` trigger, `OLD` contains the row being deleted.



\---



\# ⚔️ OLD vs NEW



For an update:



```text

OLD.salary → Value before update



NEW.salary → Value after update

```



This makes it possible to record exactly what changed.



\---



\# 📝 Audit Logging



One of the most common trigger use cases is audit logging.



Suppose an employee salary changes.



A trigger can automatically store:



```text

Employee ID

Old Salary

New Salary

Change Time

```



This creates a history of changes without requiring the application to manually insert audit records.



\---



\# 🧱 Audit Table Example



```sql

CREATE TABLE employee\_salary\_audit (

&#x20;   audit\_id INT AUTO\_INCREMENT PRIMARY KEY,

&#x20;   employee\_id INT,

&#x20;   employee\_name VARCHAR(100),

&#x20;   old\_salary DECIMAL(10,2),

&#x20;   new\_salary DECIMAL(10,2),

&#x20;   changed\_at TIMESTAMP DEFAULT CURRENT\_TIMESTAMP

);

```



This table will store salary changes.



\---



\# 🔄 AFTER UPDATE Trigger



Example:



```sql

DELIMITER //



CREATE TRIGGER trg\_employee\_salary\_update

AFTER UPDATE

ON employees

FOR EACH ROW



BEGIN



&#x20;   IF OLD.salary <> NEW.salary THEN



&#x20;       INSERT INTO employee\_salary\_audit (

&#x20;           employee\_id,

&#x20;           employee\_name,

&#x20;           old\_salary,

&#x20;           new\_salary

&#x20;       )

&#x20;       VALUES (

&#x20;           NEW.employee\_id,

&#x20;           NEW.employee\_name,

&#x20;           OLD.salary,

&#x20;           NEW.salary

&#x20;       );



&#x20;   END IF;



END //



DELIMITER ;

```



Now salary changes are logged automatically.



\---



\# ➕ AFTER INSERT Trigger



A trigger can also record newly inserted rows.



Example:



```sql

CREATE TRIGGER trg\_employee\_insert

AFTER INSERT

ON employees

FOR EACH ROW

```



It can automatically create an audit record whenever a new employee is added.



\---



\# 🗑️ AFTER DELETE Trigger



When a row is deleted, only the previous version exists.



Therefore, delete triggers normally use:



```sql

OLD.column\_name

```



Example:



```sql

OLD.employee\_id

```



This is useful for recording deleted records before their information disappears from the main table.



\---



\# 🧹 BEFORE INSERT Trigger



A `BEFORE INSERT` trigger can modify incoming values.



Example:



```sql

SET NEW.employee\_name =

&#x20;   TRIM(NEW.employee\_name);

```



This can automatically clean data before it is stored.



\---



\# ✅ Automatic Validation



A trigger can also validate data.



Example:



```sql

IF NEW.salary < 0 THEN



&#x20;   SIGNAL SQLSTATE '45000'

&#x20;   SET MESSAGE\_TEXT =

&#x20;       'Salary cannot be negative';



END IF;

```



This prevents invalid salary values from entering the table.



\---



\# 🚨 SIGNAL



MySQL's `SIGNAL` statement can raise an error.



Example:



```sql

SIGNAL SQLSTATE '45000'

SET MESSAGE\_TEXT =

&#x20;   'Invalid value';

```



This is useful for enforcing business rules.



\---



\# 🔐 Salary Validation Example



```sql

DELIMITER //



CREATE TRIGGER trg\_validate\_salary

BEFORE INSERT

ON employees

FOR EACH ROW



BEGIN



&#x20;   IF NEW.salary < 0 THEN



&#x20;       SIGNAL SQLSTATE '45000'

&#x20;       SET MESSAGE\_TEXT =

&#x20;           'Salary cannot be negative';



&#x20;   END IF;



END //



DELIMITER ;

```



Invalid data is rejected automatically.



\---



\# 🎓 Student Score Validation



Triggers can protect score values.



For example:



```sql

IF NEW.score < 0

&#x20;  OR NEW.score > 100 THEN



&#x20;   SIGNAL SQLSTATE '45000'

&#x20;   SET MESSAGE\_TEXT =

&#x20;       'Score must be between 0 and 100';



END IF;

```



This ensures score data stays within the expected range.



\---



\# 🧽 Automatic Data Cleaning



Triggers can normalize values before saving them.



Example:



```sql

SET NEW.department =

&#x20;   TRIM(NEW.department);

```



or:



```sql

SET NEW.employee\_name =

&#x20;   TRIM(NEW.employee\_name);

```



This can reduce accidental whitespace in stored values.



\---



\# 📊 Employee Change Log



Instead of tracking only salary, a general audit table can record multiple events:



```text

INSERT

UPDATE

DELETE

```



Example structure:



```sql

CREATE TABLE employee\_activity\_log (

&#x20;   log\_id INT AUTO\_INCREMENT PRIMARY KEY,

&#x20;   employee\_id INT,

&#x20;   employee\_name VARCHAR(100),

&#x20;   action\_type VARCHAR(20),

&#x20;   action\_time TIMESTAMP DEFAULT CURRENT\_TIMESTAMP

);

```



Triggers can then automatically record activity.



\---



\# 🔍 Showing Existing Triggers



MySQL allows triggers to be inspected using:



```sql

SHOW TRIGGERS;

```



This displays trigger names, events, tables, timing, and definitions.



\---



\# 🗑️ Dropping a Trigger



A trigger can be removed using:



```sql

DROP TRIGGER trigger\_name;

```



Safer version:



```sql

DROP TRIGGER IF EXISTS trigger\_name;

```



\---



\# 🆚 Trigger vs Stored Procedure



\## Stored Procedure



Executed manually:



```sql

CALL procedure\_name();

```



\## Trigger



Executed automatically:



```text

INSERT / UPDATE / DELETE event

&#x20;           ↓

&#x20;         Trigger

```



Triggers react to table events, while procedures are explicitly called.



\---



\# 🆚 Trigger vs Stored Function



A stored function:



```sql

SELECT function\_name(...);

```



returns a value.



A trigger:



```text

runs automatically because data changed

```



These tools solve different problems.



\---



\# ⚠️ Trigger Considerations



Triggers are powerful, but hidden automatic behavior can make systems harder to debug.



Important considerations include:



\- Keep trigger logic focused

\- Avoid unnecessary complexity

\- Document triggers clearly

\- Avoid creating unexpected side effects

\- Be cautious with multiple triggers on related tables

\- Remember that triggers execute automatically

\- Test triggers before production use

\- Use audit tables responsibly

\- Avoid expensive logic on frequently updated tables



\---



\# 🧠 Why Triggers Can Be Dangerous



Suppose an application runs:



```sql

UPDATE employees

SET salary = 70000

WHERE employee\_id = 5;

```



The visible query appears simple.



But triggers may automatically:



```text

Insert audit records

Validate data

Modify other values

Update another table

```



This hidden behavior can make troubleshooting difficult if triggers are poorly designed.



\---



\# 💼 Real-World Applications



Triggers are commonly used for:



\- Audit trails

\- Change history

\- Data validation

\- Automatic timestamps

\- Security logging

\- Inventory tracking

\- Employee history

\- Financial audit systems

\- Student record validation

\- Data-cleaning rules

\- Compliance systems

\- Automatic activity logs



\---



\# 💻 Practice



Today's exercises include:



\- Creating audit tables

\- Creating `AFTER INSERT` triggers

\- Creating `AFTER UPDATE` triggers

\- Creating `AFTER DELETE` triggers

\- Using `OLD`

\- Using `NEW`

\- Logging salary changes

\- Logging employee activity

\- Cleaning incoming values

\- Validating salary values

\- Validating student scores

\- Raising custom errors

\- Inspecting triggers

\- Testing triggers

\- Dropping practice triggers



All practice queries are available in:



`queries.sql`



\---



\# 🎯 What I Learned



Today I learned how MySQL triggers automatically execute when `INSERT`, `UPDATE`, or `DELETE` operations occur.



I learned how `BEFORE` triggers can validate or modify incoming data, while `AFTER` triggers are useful for logging and audit history.



`NEW` represents incoming or updated values, while `OLD` represents the previous values of existing rows.



I also learned how triggers can automatically maintain audit tables, clean data, and prevent invalid values using `SIGNAL`.



Triggers are powerful because they guarantee that certain database actions happen automatically, regardless of which application modifies the table.



However, because trigger behavior can be hidden from normal queries, triggers should remain simple, well documented, and focused on clear database responsibilities.



\---



\## 📈 Challenge Progress



\*\*Day 28 / 30 ✅\*\*



Previous: \*\*Day 27 - Stored Functions \& Custom SQL Functions\*\*



Next: \*\*Day 29 - Constraints \& Advanced Data Integrity\*\*

