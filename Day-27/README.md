\# Day 27 - Stored Functions \& Custom SQL Functions 🧩



Welcome to \*\*Day 27 of my 30 Days of SQL Challenge\*\*.



Today I explored \*\*Stored Functions in MySQL\*\*.



A stored function is a reusable database object that accepts parameters, performs logic, and returns a single value.



Unlike stored procedures, which are normally executed using `CALL`, stored functions can be used directly inside SQL expressions such as:



```sql

SELECT function\_name(...);

```



Stored functions are useful when the same calculation or classification logic needs to be reused across multiple queries.



\---



\## 📚 Concepts Covered



\- `CREATE FUNCTION`

\- `DROP FUNCTION`

\- Function parameters

\- `RETURNS`

\- `RETURN`

\- `DETERMINISTIC`

\- `NO SQL`

\- Local variables

\- `DECLARE`

\- `SET`

\- `SELECT ... INTO`

\- `IF`

\- `CASE`

\- Mathematical functions

\- Text-processing functions

\- Classification functions

\- Functions inside `SELECT`

\- Functions with tables

\- Stored functions vs stored procedures



\---



\# 🧠 What is a Stored Function?



A stored function is reusable SQL logic stored inside the database.



It accepts zero or more parameters and returns exactly one value.



Basic structure:



```sql

DELIMITER //



CREATE FUNCTION function\_name(

&#x20;   parameter\_name data\_type

)

RETURNS return\_data\_type

DETERMINISTIC

NO SQL



BEGIN



&#x20;   RETURN some\_value;



END //



DELIMITER ;

```



The function can then be used like:



```sql

SELECT function\_name(value);

```



\---



\# 🔄 Stored Function vs Stored Procedure



Stored procedures and stored functions both store reusable database logic, but they are used differently.



\## Stored Procedure



Executed using:



```sql

CALL procedure\_name();

```



A procedure can:



\- Return result sets

\- Use `IN`, `OUT`, and `INOUT` parameters

\- Execute multiple operations

\- Perform broader database workflows



\---



\## Stored Function



Used inside an expression:



```sql

SELECT function\_name(...);

```



A function:



\- Returns one value

\- Can be called inside queries

\- Is useful for reusable calculations

\- Can simplify repeated expressions



\---



\# 🧮 Simple Mathematical Function



Example:



```sql

DELIMITER //



CREATE FUNCTION CalculateBonus(

&#x20;   salary\_amount DECIMAL(10,2)

)

RETURNS DECIMAL(10,2)

DETERMINISTIC

NO SQL



BEGIN



&#x20;   RETURN salary\_amount \* 0.10;



END //



DELIMITER ;

```



Usage:



```sql

SELECT CalculateBonus(50000);

```



Result:



```text

5000

```



\---



\# 📥 Function Parameters



Function parameters behave as input values.



Example:



```sql

CREATE FUNCTION AddNumbers(

&#x20;   number\_one INT,

&#x20;   number\_two INT

)

```



The function receives both values.



Usage:



```sql

SELECT AddNumbers(10, 20);

```



\---



\# 📤 RETURNS



Every stored function must declare its return type.



Example:



```sql

RETURNS DECIMAL(10,2)

```



or:



```sql

RETURNS VARCHAR(50)

```



The declared type should match the value produced by the function.



\---



\# ↩️ RETURN



`RETURN` sends the final result back to the query.



Example:



```sql

RETURN salary\_amount \* 0.10;

```



A stored function must return a value.



\---



\# 🎯 DETERMINISTIC



A function can be declared:



```sql

DETERMINISTIC

```



when the same input values are expected to produce the same result.



For example:



```text

CalculateBonus(50000)

```



should always produce the same value if its logic is purely based on that input.



\---



\# 📘 NO SQL



`NO SQL` indicates that the function itself does not read or modify database tables.



Example:



```sql

CREATE FUNCTION CalculateBonus(...)

RETURNS DECIMAL(10,2)

DETERMINISTIC

NO SQL

```



A function that reads table data should be declared appropriately instead of incorrectly claiming `NO SQL`.



\---



\# 🏷️ Salary Classification Function



A function can return text.



Example:



```sql

DELIMITER //



CREATE FUNCTION SalaryCategory(

&#x20;   employee\_salary DECIMAL(10,2)

)

RETURNS VARCHAR(30)

DETERMINISTIC

NO SQL



BEGIN



&#x20;   RETURN CASE



&#x20;       WHEN employee\_salary >= 80000

&#x20;           THEN 'High Salary'



&#x20;       WHEN employee\_salary >= 60000

&#x20;           THEN 'Medium Salary'



&#x20;       ELSE 'Entry Salary'



&#x20;   END;



END //



DELIMITER ;

```



Usage:



```sql

SELECT SalaryCategory(75000);

```



Result:



```text

Medium Salary

```



\---



\# 🎓 Student Performance Function



Functions can also classify student performance.



Example:



```sql

CREATE FUNCTION PerformanceCategory(

&#x20;   student\_score DECIMAL(5,2)

)

RETURNS VARCHAR(30)

```



Possible categories:



```text

Excellent

Very Good

Good

Average

Needs Improvement

```



\---



\# 🧩 Using Functions with Table Columns



One major advantage of stored functions is that they can be applied directly to table values.



Example:



```sql

SELECT

&#x20;   employee\_name,

&#x20;   salary,

&#x20;   SalaryCategory(salary)

&#x20;       AS salary\_category

FROM employees;

```



The function runs for each returned row.



\---



\# 💰 Bonus Calculation



Instead of repeating:



```sql

salary \* 0.10

```



throughout many queries, we can create:



```sql

CalculateBonus(salary)

```



Then use:



```sql

SELECT

&#x20;   employee\_name,

&#x20;   salary,

&#x20;   CalculateBonus(salary)

&#x20;       AS bonus

FROM employees;

```



This centralizes the calculation.



\---



\# 🔢 Percentage-Based Function



A function can accept multiple parameters.



Example:



```sql

CREATE FUNCTION CalculatePercentage(

&#x20;   value\_amount DECIMAL(10,2),

&#x20;   percentage\_value DECIMAL(5,2)

)

```



The calculation could be:



```text

value × percentage / 100

```



This creates a reusable percentage calculator.



\---



\# 📦 Local Variables



Functions can use local variables.



Example:



```sql

BEGIN



&#x20;   DECLARE bonus\_amount DECIMAL(10,2);



&#x20;   SET bonus\_amount = salary\_amount \* 0.10;



&#x20;   RETURN bonus\_amount;



END

```



This is helpful when calculations involve multiple steps.



\---



\# 🧠 IF Logic Inside Functions



Functions can use `IF`.



Example:



```sql

IF score >= 90 THEN

&#x20;   RETURN 'Excellent';



ELSEIF score >= 80 THEN

&#x20;   RETURN 'Very Good';



ELSE

&#x20;   RETURN 'Needs Improvement';



END IF;

```



This allows reusable decision logic.



\---



\# 🔡 Text Functions



Stored functions can also manipulate strings.



Example:



```sql

CREATE FUNCTION FormatEmployeeName(

&#x20;   employee\_name VARCHAR(100)

)

RETURNS VARCHAR(120)

DETERMINISTIC

NO SQL



BEGIN



&#x20;   RETURN CONCAT(

&#x20;       'Employee: ',

&#x20;       UPPER(employee\_name)

&#x20;   );



END;

```



\---



\# 🆔 Generating Business Labels



A function can combine values into business-friendly labels.



For example:



```text

EMP-0001

EMP-0002

EMP-0003

```



A function could generate these values from an employee ID.



```sql

RETURN CONCAT(

&#x20;   'EMP-',

&#x20;   LPAD(employee\_id, 4, '0')

);

```



\---



\# 🧪 Handling NULL Values



Functions should consider `NULL`.



Example:



```sql

IF salary\_amount IS NULL THEN

&#x20;   RETURN 0;

END IF;

```



This makes the function more predictable when invalid or missing input is supplied.



\---



\# 🔐 Functions and Database Logic



Stored functions help centralize repeated business calculations.



Instead of having:



```text

Application A → calculation logic



Application B → duplicate calculation logic



Report C → another copy

```



the calculation can live in one database function:



```text

Database Function

&#x20;     ↓

Reusable Logic

```



\---



\# ⚠️ Stored Function Limitations



Stored functions should be kept focused.



Important considerations include:



\- They return one value

\- Complex logic can become difficult to debug

\- Excessive function calls may affect query performance

\- Database-specific functions reduce portability

\- Functions should not hide inefficient logic

\- Data types should be chosen carefully

\- NULL behavior should be considered

\- Business logic should remain understandable



\---



\# 🧹 DROP FUNCTION



A function can be deleted using:



```sql

DROP FUNCTION function\_name;

```



Safer version:



```sql

DROP FUNCTION IF EXISTS function\_name;

```



This is useful when recreating functions during development.



\---



\# 💼 Real-World Applications



Stored functions can be used for:



\- Salary calculations

\- Tax calculations

\- Bonus calculations

\- Performance classifications

\- Customer segmentation

\- Product pricing

\- Discount calculations

\- Data formatting

\- Business-code generation

\- Score classification

\- Financial calculations

\- Reusable reporting logic



\---



\# 💻 Practice



Today's exercises include:



\- Creating basic functions

\- Calling stored functions

\- Mathematical functions

\- Functions with multiple parameters

\- Salary classification

\- Student performance classification

\- Bonus calculations

\- Percentage calculations

\- Text formatting

\- ID formatting

\- NULL handling

\- Local variables

\- Conditional functions

\- Functions applied to table columns

\- Reusable business calculations



All practice queries are available in:



`queries.sql`



\---



\# 🎯 What I Learned



Today I learned how MySQL stored functions can package repeated calculations and classification logic into reusable database objects.



Unlike stored procedures, functions return a single value and can be used directly inside `SELECT`, `WHERE`, and other SQL expressions where permitted.



I learned how to define return types with `RETURNS`, produce results with `RETURN`, accept parameters, declare local variables, and use conditional logic.



I also learned how custom functions can simplify repeated calculations such as bonuses, salary categories, percentages, student performance labels, and formatted business identifiers.



Stored functions are useful when a calculation appears frequently across reports and queries, but they should remain focused, understandable, and efficient.



\---



\## 📈 Challenge Progress



\*\*Day 27 / 30 ✅\*\*



Previous: \*\*Day 26 - Stored Procedures \& Parameters\*\*



Next: \*\*Day 28 - Triggers \& Automated Database Actions\*\*

