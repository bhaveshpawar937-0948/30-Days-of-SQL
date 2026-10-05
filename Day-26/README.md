\# Day 26 - Stored Procedures \& Parameters ⚙️



Welcome to \*\*Day 26 of my 30 Days of SQL Challenge\*\*.



Today I explored \*\*Stored Procedures in MySQL\*\*.



A stored procedure is a reusable collection of SQL statements stored inside the database. Instead of repeatedly writing the same SQL logic, we can create a procedure once and execute it whenever needed using `CALL`.



I also explored parameters, which allow values to be passed into and returned from procedures.



The main concepts covered today are:



\- `CREATE PROCEDURE`

\- `CALL`

\- `DROP PROCEDURE`

\- `DELIMITER`

\- `IN` parameters

\- `OUT` parameters

\- `INOUT` parameters

\- Local variables

\- `DECLARE`

\- `SET`

\- `SELECT ... INTO`

\- Conditional logic inside procedures



\---



\## 📚 Concepts Covered



\- Stored procedures

\- Creating procedures

\- Executing procedures

\- Removing procedures

\- MySQL delimiters

\- Input parameters

\- Output parameters

\- Input-output parameters

\- Local variables

\- Assigning values

\- Returning calculated results

\- Procedures with filters

\- Procedures with aggregates

\- Procedures with multiple parameters

\- Conditional procedure logic

\- Reusable database operations



\---



\# 🧠 What is a Stored Procedure?



A stored procedure is a named collection of SQL statements stored inside the database.



Instead of repeatedly writing:



```sql

SELECT

&#x20;   employee\_name,

&#x20;   department,

&#x20;   salary

FROM employees

WHERE department = 'Engineering';

```



we can create a procedure:



```sql

CREATE PROCEDURE GetEngineeringEmployees()

BEGIN



&#x20;   SELECT

&#x20;       employee\_name,

&#x20;       department,

&#x20;       salary

&#x20;   FROM employees

&#x20;   WHERE department = 'Engineering';



END;

```



Then execute it using:



```sql

CALL GetEngineeringEmployees();

```



\---



\# ⚙️ Why Use Stored Procedures?



Stored procedures are useful when SQL logic needs to be executed repeatedly.



Conceptually:



```text

Repeated SQL Logic

&#x20;       ↓

Stored Procedure

&#x20;       ↓

CALL procedure\_name()

&#x20;       ↓

Reusable Result

```



They can help:



\- Reuse database logic

\- Centralize operations

\- Accept dynamic parameters

\- Perform multiple SQL statements

\- Reduce duplicated SQL

\- Encapsulate business rules



\---



\# 🔧 DELIMITER



MySQL normally treats:



```text

;

```



as the end of a SQL statement.



A stored procedure contains multiple statements ending with semicolons, so we temporarily change the delimiter.



Example:



```sql

DELIMITER //



CREATE PROCEDURE GetEmployees()

BEGIN



&#x20;   SELECT \*

&#x20;   FROM employees;



END //



DELIMITER ;

```



Here:



```text

//

```



temporarily marks the end of the entire procedure definition.



After creating the procedure, the normal semicolon delimiter is restored.



\---



\# ▶️ CALL



A stored procedure is executed using:



```sql

CALL procedure\_name();

```



Example:



```sql

CALL GetEmployees();

```



\---



\# 🗑️ DROP PROCEDURE



A stored procedure can be removed using:



```sql

DROP PROCEDURE procedure\_name;

```



A safer version is:



```sql

DROP PROCEDURE IF EXISTS procedure\_name;

```



This is particularly useful while developing and recreating procedures.



\---



\# 📥 IN Parameters



An `IN` parameter sends a value into a procedure.



Example:



```sql

DELIMITER //



CREATE PROCEDURE GetEmployeesByDepartment(

&#x20;   IN dept\_name VARCHAR(100)

)

BEGIN



&#x20;   SELECT

&#x20;       employee\_name,

&#x20;       department,

&#x20;       salary

&#x20;   FROM employees

&#x20;   WHERE department = dept\_name;



END //



DELIMITER ;

```



Execute it with:



```sql

CALL GetEmployeesByDepartment('Engineering');

```



The same procedure can now work with different departments.



\---



\# 🔢 Multiple IN Parameters



A procedure can accept multiple values.



```sql

CREATE PROCEDURE GetEmployeesBySalaryRange(

&#x20;   IN minimum\_salary DECIMAL(10,2),

&#x20;   IN maximum\_salary DECIMAL(10,2)

)

```



Then:



```sql

CALL GetEmployeesBySalaryRange(

&#x20;   50000,

&#x20;   80000

);

```



This makes procedures flexible and reusable.



\---



\# 📤 OUT Parameters



An `OUT` parameter returns a value from a procedure.



Example:



```sql

DELIMITER //



CREATE PROCEDURE GetEmployeeCount(

&#x20;   OUT total\_employees INT

)

BEGIN



&#x20;   SELECT COUNT(\*)

&#x20;   INTO total\_employees

&#x20;   FROM employees;



END //



DELIMITER ;

```



Call it using:



```sql

CALL GetEmployeeCount(@total);

```



Then retrieve the result:



```sql

SELECT @total;

```



\---



\# 🔄 INOUT Parameters



An `INOUT` parameter works in both directions.



It receives an initial value and returns a modified value.



Example:



```sql

DELIMITER //



CREATE PROCEDURE AddBonus(

&#x20;   INOUT amount DECIMAL(10,2)

)

BEGIN



&#x20;   SET amount = amount + 1000;



END //



DELIMITER ;

```



Usage:



```sql

SET @salary = 50000;



CALL AddBonus(@salary);



SELECT @salary;

```



Result:



```text

51000

```



\---



\# 📦 Local Variables



Variables can be declared inside a procedure.



```sql

DECLARE employee\_total INT;

```



Local variables must be declared near the beginning of a `BEGIN ... END` block before executable statements in that block.



Example:



```sql

BEGIN



&#x20;   DECLARE employee\_total INT;



&#x20;   SELECT COUNT(\*)

&#x20;   INTO employee\_total

&#x20;   FROM employees;



&#x20;   SELECT employee\_total;



END

```



\---



\# 🎯 SELECT INTO



`SELECT ... INTO` stores a query result in a variable.



Example:



```sql

SELECT AVG(salary)

INTO average\_salary

FROM employees;

```



The calculated value is now available through:



```text

average\_salary

```



inside the procedure.



\---



\# 🧮 Procedures with Aggregates



Stored procedures can perform analytical calculations.



Example:



```sql

CREATE PROCEDURE DepartmentAverageSalary(

&#x20;   IN dept\_name VARCHAR(100)

)

BEGIN



&#x20;   SELECT

&#x20;       department,

&#x20;       ROUND(AVG(salary), 2)

&#x20;           AS average\_salary

&#x20;   FROM employees

&#x20;   WHERE department = dept\_name

&#x20;   GROUP BY department;



END;

```



Now:



```sql

CALL DepartmentAverageSalary('Engineering');

```



returns the average salary for that department.



\---



\# 🧠 Conditional Logic



Procedures can contain conditions.



Example:



```sql

IF employee\_salary >= 80000 THEN



&#x20;   SET salary\_level = 'High';



ELSEIF employee\_salary >= 60000 THEN



&#x20;   SET salary\_level = 'Medium';



ELSE



&#x20;   SET salary\_level = 'Entry';



END IF;

```



This allows procedures to perform more than simple queries.



\---



\# 🧪 Procedure with IF



Example:



```sql

DELIMITER //



CREATE PROCEDURE ClassifySalary(

&#x20;   IN employee\_salary DECIMAL(10,2)

)

BEGIN



&#x20;   IF employee\_salary >= 80000 THEN



&#x20;       SELECT 'High Salary' AS category;



&#x20;   ELSEIF employee\_salary >= 60000 THEN



&#x20;       SELECT 'Medium Salary' AS category;



&#x20;   ELSE



&#x20;       SELECT 'Entry Salary' AS category;



&#x20;   END IF;



END //



DELIMITER ;

```



Call it with:



```sql

CALL ClassifySalary(75000);

```



\---



\# 🆚 Stored Procedure vs View



A view represents a reusable query:



```text

VIEW

→ Reusable virtual table

```



A stored procedure represents reusable executable SQL logic:



```text

PROCEDURE

→ Reusable SQL operations

```



Views are queried with:



```sql

SELECT \*

FROM view\_name;

```



Procedures are executed with:



```sql

CALL procedure\_name();

```



Procedures can also accept parameters and contain multiple statements.



\---



\# 🆚 Stored Procedure vs Function



Stored procedures and SQL functions are related but serve different purposes.



A procedure is normally executed explicitly:



```sql

CALL procedure\_name();

```



A function is normally used inside an expression:



```sql

SELECT function\_name(...);

```



Stored functions will be explored separately.



\---



\# 🏢 Department Reporting Procedure



A reusable department report could be:



```sql

DELIMITER //



CREATE PROCEDURE DepartmentReport(

&#x20;   IN dept\_name VARCHAR(100)

)

BEGIN



&#x20;   SELECT

&#x20;       department,

&#x20;       COUNT(\*) AS employee\_count,

&#x20;       ROUND(AVG(salary), 2)

&#x20;           AS average\_salary,

&#x20;       MIN(salary)

&#x20;           AS minimum\_salary,

&#x20;       MAX(salary)

&#x20;           AS maximum\_salary

&#x20;   FROM employees

&#x20;   WHERE department = dept\_name

&#x20;   GROUP BY department;



END //



DELIMITER ;

```



The same report works for different departments.



\---



\# 🎓 Student Performance Procedure



Procedures can also be useful for student analytics.



```sql

CREATE PROCEDURE GetStudentsAboveScore(

&#x20;   IN minimum\_score DECIMAL(5,2)

)

```



Then:



```sql

CALL GetStudentsAboveScore(80);

```



returns students meeting the required score.



\---



\# 🔐 Stored Procedures and Access Control



Stored procedures can also help centralize database operations.



Applications can sometimes be given permission to execute approved procedures instead of receiving unrestricted access to every underlying table operation.



Actual security depends on database permissions, procedure security settings, and deployment configuration.



\---



\# ⚠️ Important Considerations



Stored procedures are powerful, but they should be used carefully.



Important considerations include:



\- Procedure logic can become complex

\- Debugging may be harder than application code

\- Database-specific syntax can reduce portability

\- Changes should be version controlled

\- Procedures should have clear responsibilities

\- Input values should be validated appropriately

\- Naming should remain consistent



Stored procedures are most useful when they simplify repeated database operations rather than turning the database into an unnecessarily complicated application layer.



\---



\# 💼 Real-World Applications



Stored procedures are commonly used for:



\- Reusable reports

\- Payroll calculations

\- Banking operations

\- Order processing

\- Inventory management

\- Customer analytics

\- Data validation

\- Administrative operations

\- Batch processing

\- ETL workflows

\- Reporting systems

\- Business-rule execution



\---



\# 💻 Practice



Today's exercises include:



\- Creating basic procedures

\- Calling procedures

\- Dropping procedures

\- Using `IN` parameters

\- Using multiple parameters

\- Using `OUT` parameters

\- Using `INOUT` parameters

\- Declaring local variables

\- Using `SELECT INTO`

\- Department reporting

\- Salary filtering

\- Student-score filtering

\- Aggregate procedures

\- Conditional procedures

\- Reusable analytical procedures



All practice queries are available in:



`queries.sql`



\---



\# 🎯 What I Learned



Today I learned how stored procedures allow reusable SQL logic to be stored and executed directly inside MySQL.



I learned how `CREATE PROCEDURE` defines a procedure and how `CALL` executes it.



I also learned the purpose of MySQL's `DELIMITER` command when defining multi-statement procedures.



`IN` parameters allow values to enter a procedure, `OUT` parameters return values, and `INOUT` parameters can perform both roles.



Local variables, `SELECT INTO`, and conditional statements make stored procedures capable of implementing more advanced database logic.



Stored procedures are especially useful when database operations need to be standardized, reused, and executed with different input values.



\---



\## 📈 Challenge Progress



\*\*Day 26 / 30 ✅\*\*



Previous: \*\*Day 25 - Transactions, COMMIT, ROLLBACK \& SAVEPOINT\*\*



Next: \*\*Day 27 - Stored Functions \& Custom SQL Functions\*\*

