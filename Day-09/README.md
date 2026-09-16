\# Day 09 - SELF JOIN \& Hierarchical Relationships 👥



Welcome to \*\*Day 09 of my 30 Days of SQL Challenge\*\*.



Today I explored the `SELF JOIN`, a technique where a table is joined to itself.



Self joins are useful when rows inside the same table have relationships with other rows from that table.



A common real-world example is an employee table where every employee may have another employee assigned as their manager.



\---



\## 📚 Concepts Covered



\* Self joins

\* Joining a table to itself

\* Table aliases

\* Employee-manager relationships

\* Parent-child relationships

\* Hierarchical data

\* Finding records without a parent

\* Finding employees under a specific manager

\* Comparing rows within the same table



\---



\## 🧠 What is a SELF JOIN?



A self join is a normal SQL join where the same table appears more than once in the query.



Aliases are required so SQL can distinguish between the two instances.



Example:



```sql

SELECT

&#x20;   e.employee\_name AS employee,

&#x20;   m.employee\_name AS manager

FROM employees AS e

LEFT JOIN employees AS m

&#x20;   ON e.manager\_id = m.employee\_id;

```



Here:



```text

e → represents the employee



m → represents the manager

```



Both aliases refer to the same `employees` table.



\---



\## 🔗 Hierarchical Relationships



Consider an employee table:



| employee\_id | employee\_name | manager\_id |

| ----------: | ------------- | ---------: |

|           1 | Ananya        |       NULL |

|           2 | Rahul         |          1 |

|           3 | Priya         |          1 |

|           4 | Aman          |          2 |



This tells us:



\* Ananya has no manager

\* Rahul reports to Ananya

\* Priya reports to Ananya

\* Aman reports to Rahul



The relationship exists entirely inside the same table.



\---



\## 🏷️ Why Aliases Matter



Without aliases, SQL would not know which instance of the table represents the employee and which represents the manager.



Example:



```sql

FROM employees AS e

LEFT JOIN employees AS m

```



Aliases make the relationship much easier to understand.



\---



\## 👑 Finding Top-Level Employees



Employees without a manager can be identified using:



```sql

SELECT

&#x20;   employee\_name

FROM employees

WHERE manager\_id IS NULL;

```



These records usually represent top-level managers or organization leaders.



\---



\## 🔎 Finding Employees Under a Manager



A self join can be used to display each manager and the employees reporting to them.



```sql

SELECT

&#x20;   m.employee\_name AS manager,

&#x20;   e.employee\_name AS employee

FROM employees AS e

JOIN employees AS m

&#x20;   ON e.manager\_id = m.employee\_id;

```



\---



\## 💡 Where SELF JOIN is Used



Self joins can be useful for:



\* Employee-manager structures

\* Product categories and subcategories

\* Referral systems

\* Family relationships

\* Organizational hierarchies

\* Parent-child records

\* Comparing records within the same dataset



\---



\## 💻 Practice



Today's exercises include:



\* Displaying employees and managers

\* Finding employees without managers

\* Finding employees reporting to a specific manager

\* Listing manager-employee relationships

\* Finding employees who manage others

\* Displaying employees from the same department

\* Comparing records from the same table

\* Building an organizational hierarchy report



All SQL practice is available in:



`queries.sql`



\---



\## 🎯 What I Learned



Today I learned that a SQL table can be joined with itself when relationships exist between records inside the same dataset.



Using aliases makes it possible to treat the same table as two logical datasets.



Self joins are particularly useful for hierarchical structures such as employee-manager relationships and parent-child data.



\---



\## 📈 Challenge Progress



\*\*Day 09 / 30 ✅\*\*



Previous: \*\*Day 08 - RIGHT JOIN \& Join Direction\*\*



Next: \*\*Day 10 - CROSS JOIN \& Cartesian Products\*\*



