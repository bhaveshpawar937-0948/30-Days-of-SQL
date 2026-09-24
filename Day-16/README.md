\# Day 16 - SQL String Functions \& Text Manipulation 🔤



Welcome to \*\*Day 16 of my 30 Days of SQL Challenge\*\*.



Today I explored \*\*SQL string functions\*\*, which are used to clean, transform, extract, combine, and analyze text data.



Real-world databases contain large amounts of textual information such as customer names, email addresses, addresses, product names, departments, job titles, and identifiers.



String functions allow this data to be transformed directly inside SQL without modifying the original stored values.



\---



\## 📚 Concepts Covered



\- `UPPER()`

\- `LOWER()`

\- `LENGTH()`

\- `CHAR\_LENGTH()`

\- `CONCAT()`

\- `CONCAT\_WS()`

\- `TRIM()`

\- `LTRIM()`

\- `RTRIM()`

\- `LEFT()`

\- `RIGHT()`

\- `SUBSTRING()`

\- `REPLACE()`

\- `LOCATE()`

\- `INSTR()`

\- `REVERSE()`

\- `LPAD()`

\- `RPAD()`

\- Text standardization

\- String extraction

\- Building formatted labels



\---



\# 🔠 UPPER()



`UPPER()` converts text to uppercase.



```sql

SELECT

&#x20;   employee\_name,

&#x20;   UPPER(employee\_name) AS uppercase\_name

FROM employees;

```



Example:



```text

Bhavesh Pawar

```



becomes:



```text

BHAVESH PAWAR

```



\---



\# 🔡 LOWER()



`LOWER()` converts text to lowercase.



```sql

SELECT

&#x20;   employee\_name,

&#x20;   LOWER(employee\_name) AS lowercase\_name

FROM employees;

```



This is especially useful when standardizing text before comparisons.



\---



\# 📏 LENGTH()



`LENGTH()` returns the length of a string in \*\*bytes\*\*.



```sql

SELECT

&#x20;   employee\_name,

&#x20;   LENGTH(employee\_name) AS name\_length

FROM employees;

```



\---



\# 📐 CHAR\_LENGTH()



`CHAR\_LENGTH()` returns the number of characters.



```sql

SELECT

&#x20;   employee\_name,

&#x20;   CHAR\_LENGTH(employee\_name) AS characters

FROM employees;

```



For ordinary English text, `LENGTH()` and `CHAR\_LENGTH()` often return the same number.



For multibyte characters, however, their results can differ.



\---



\# 🔗 CONCAT()



`CONCAT()` joins multiple strings together.



```sql

SELECT

&#x20;   CONCAT(employee\_name, ' - ', job\_role)

&#x20;       AS employee\_details

FROM employees;

```



Example output:



```text

Amit Sharma - Data Analyst

```



\---



\# 🧵 CONCAT\_WS()



`CONCAT\_WS()` means:



```text

Concatenate With Separator

```



Example:



```sql

SELECT

&#x20;   CONCAT\_WS(

&#x20;       ' | ',

&#x20;       employee\_name,

&#x20;       department,

&#x20;       job\_role

&#x20;   ) AS employee\_summary

FROM employees;

```



The first argument defines the separator.



\---



\# ✂️ TRIM()



`TRIM()` removes unwanted spaces from the beginning and end of a string.



```sql

SELECT

&#x20;   TRIM('   Data Analyst   ');

```



Result:



```text

Data Analyst

```



\---



\## LTRIM()



Removes spaces from the left side.



```sql

SELECT LTRIM('   SQL');

```



\---



\## RTRIM()



Removes spaces from the right side.



```sql

SELECT RTRIM('SQL   ');

```



These functions are useful during data-cleaning operations.



\---



\# ⬅️ LEFT()



`LEFT()` extracts characters from the beginning of a string.



```sql

SELECT

&#x20;   employee\_name,

&#x20;   LEFT(employee\_name, 3)

FROM employees;

```



Example:



```text

Bhavesh → Bha

```



\---



\# ➡️ RIGHT()



`RIGHT()` extracts characters from the end.



```sql

SELECT

&#x20;   employee\_name,

&#x20;   RIGHT(employee\_name, 3)

FROM employees;

```



Example:



```text

Bhavesh → esh

```



\---



\# 🔍 SUBSTRING()



`SUBSTRING()` extracts part of a string.



Syntax:



```sql

SUBSTRING(string, start\_position, length)

```



Example:



```sql

SELECT

&#x20;   SUBSTRING('Data Engineering', 6, 11);

```



Result:



```text

Engineering

```



SQL string positions begin at:



```text

1

```



not zero.



\---



\# 🔄 REPLACE()



`REPLACE()` substitutes text inside another string.



```sql

SELECT

&#x20;   REPLACE(

&#x20;       'Junior Data Analyst',

&#x20;       'Junior',

&#x20;       'Senior'

&#x20;   );

```



Result:



```text

Senior Data Analyst

```



This is useful for text cleaning and standardization.



\---



\# 📍 LOCATE()



`LOCATE()` finds the position of text inside another string.



```sql

SELECT

&#x20;   LOCATE('Data', 'Senior Data Analyst');

```



The result is the starting position of the matching text.



If the text does not exist, MySQL returns:



```text

0

```



\---



\# 🔎 INSTR()



`INSTR()` performs a similar search.



```sql

SELECT

&#x20;   INSTR('Data Engineering', 'Engineering');

```



It returns the position where the requested substring begins.



\---



\# 🔃 REVERSE()



`REVERSE()` reverses a string.



```sql

SELECT REVERSE('SQL');

```



Result:



```text

LQS

```



It is not an everyday analytics function, but it is useful for understanding string transformations and solving certain text-processing problems.



\---



\# 🧱 LPAD()



`LPAD()` adds characters to the left side until the requested length is reached.



```sql

SELECT LPAD('25', 5, '0');

```



Result:



```text

00025

```



This can be useful for formatted identifiers.



\---



\# 🧱 RPAD()



`RPAD()` performs the same operation on the right.



```sql

SELECT RPAD('SQL', 6, '.');

```



Result:



```text

SQL...

```



\---



\# 🧹 Text Standardization



Suppose department values have inconsistent capitalization:



```text

analytics

ANALYTICS

Analytics

```



We can standardize them:



```sql

SELECT

&#x20;   UPPER(TRIM(department))

FROM employees;

```



Result:



```text

ANALYTICS

```



Combining string functions is extremely useful during data cleaning.



\---



\# 🏷️ Creating Employee Codes



Multiple string functions can be combined.



```sql

SELECT

&#x20;   employee\_name,

&#x20;   CONCAT(

&#x20;       UPPER(LEFT(department, 3)),

&#x20;       '-',

&#x20;       LPAD(employee\_id, 4, '0')

&#x20;   ) AS employee\_code

FROM employees;

```



Possible output:



```text

ANA-0007

ENG-0012

```



This demonstrates how SQL can generate formatted identifiers dynamically.



\---



\# 💼 Real-World Applications



String functions are commonly used for:



\- Cleaning customer names

\- Standardizing capitalization

\- Formatting reports

\- Extracting portions of identifiers

\- Processing email addresses

\- Creating employee codes

\- Cleaning imported CSV data

\- Searching text fields

\- Creating dashboard labels

\- Formatting product information

\- ETL transformations

\- Data-quality checks



\---



\## ⚠️ Important Principle



String functions usually transform the \*\*query result\*\*, not the stored database value.



For example:



```sql

SELECT UPPER(employee\_name)

FROM employees;

```



does not permanently convert the employee names to uppercase.



It only changes how the values appear in that query result.



\---



\# 💻 Practice



Today's exercises include:



\- Converting text to uppercase

\- Converting text to lowercase

\- Measuring string lengths

\- Combining columns

\- Removing whitespace

\- Extracting text from the left and right

\- Extracting substrings

\- Replacing text

\- Finding substring positions

\- Reversing strings

\- Padding identifiers

\- Standardizing department names

\- Creating employee codes

\- Creating student codes

\- Building formatted reports

\- Performing text-quality checks



All practice queries are available in:



`queries.sql`



\---



\# 🎯 What I Learned



Today I learned how SQL can manipulate and clean textual data using built-in string functions.



Functions such as `UPPER()`, `LOWER()`, `TRIM()`, and `REPLACE()` are useful for data standardization, while `LEFT()`, `RIGHT()`, and `SUBSTRING()` allow specific portions of strings to be extracted.



I also learned how `CONCAT()` and `CONCAT\_WS()` can create readable labels and how functions such as `LPAD()` can generate consistently formatted identifiers.



String manipulation is especially valuable in data cleaning, analytics, ETL pipelines, and preparing data for dashboards or machine-learning workflows.



\---



\## 📈 Challenge Progress



\*\*Day 16 / 30 ✅\*\*



Previous: \*\*Day 15 - NULL Handling: COALESCE, IFNULL \& NULLIF\*\*



Next: \*\*Day 17 - Date \& Time Functions\*\*

