\# Day 25 - Transactions, COMMIT, ROLLBACK \& SAVEPOINT 🔐



Welcome to \*\*Day 25 of my 30 Days of SQL Challenge\*\*.



Today I explored \*\*SQL transactions\*\*, which allow multiple database operations to be treated as one logical unit of work.



Transactions are essential whenever several related changes must either succeed together or be safely reversed.



The main commands covered today are:



\- `START TRANSACTION`

\- `COMMIT`

\- `ROLLBACK`

\- `SAVEPOINT`

\- `ROLLBACK TO SAVEPOINT`

\- `RELEASE SAVEPOINT`



Transactions are especially important in banking, payments, inventory systems, booking applications, order processing, and other systems where partial updates could leave data inconsistent.



\---



\## 📚 Concepts Covered



\- SQL transactions

\- `START TRANSACTION`

\- `COMMIT`

\- `ROLLBACK`

\- `SAVEPOINT`

\- `ROLLBACK TO SAVEPOINT`

\- `RELEASE SAVEPOINT`

\- Autocommit

\- Atomic operations

\- Multi-statement transactions

\- Transaction safety

\- ACID properties

\- Transaction boundaries

\- Error-handling concepts

\- Banking transfer scenarios

\- Inventory transactions



\---



\# 🧠 What is a Transaction?



A transaction is a sequence of SQL operations treated as one logical unit.



Example:



```sql

START TRANSACTION;



UPDATE accounts

SET balance = balance - 1000

WHERE account\_id = 1;



UPDATE accounts

SET balance = balance + 1000

WHERE account\_id = 2;



COMMIT;

```



Both operations belong to the same transaction.



This is important because transferring money requires two related changes:



```text

Sender balance decreases

&#x20;       +

Receiver balance increases

```



The database should not permanently apply only half of the transfer.



\---



\# 🚦 START TRANSACTION



A transaction can be started using:



```sql

START TRANSACTION;

```



After this point, supported changes remain part of the current transaction until it is completed using `COMMIT` or cancelled using `ROLLBACK`.



\---



\# ✅ COMMIT



`COMMIT` permanently saves the changes made during the current transaction.



Example:



```sql

START TRANSACTION;



UPDATE employees

SET salary = salary + 5000

WHERE employee\_id = 1;



COMMIT;

```



Conceptually:



```text

START TRANSACTION

&#x20;      ↓

Make changes

&#x20;      ↓

COMMIT

&#x20;      ↓

Changes become permanent

```



\---



\# ↩️ ROLLBACK



`ROLLBACK` cancels uncommitted changes in the current transaction.



Example:



```sql

START TRANSACTION;



UPDATE employees

SET salary = salary + 5000

WHERE employee\_id = 1;



ROLLBACK;

```



The salary modification is reversed because it was not committed.



Conceptually:



```text

START TRANSACTION

&#x20;      ↓

Make changes

&#x20;      ↓

ROLLBACK

&#x20;      ↓

Return to transaction starting state

```



\---



\# 💾 SAVEPOINT



A savepoint creates a checkpoint inside a transaction.



Example:



```sql

START TRANSACTION;



UPDATE employees

SET salary = salary + 1000

WHERE employee\_id = 1;



SAVEPOINT salary\_updated;



UPDATE employees

SET department = 'Management'

WHERE employee\_id = 1;

```



Now the transaction contains a named checkpoint called:



```text

salary\_updated

```



\---



\# ⏪ ROLLBACK TO SAVEPOINT



Instead of cancelling the entire transaction, we can return to a particular savepoint.



```sql

ROLLBACK TO SAVEPOINT salary\_updated;

```



Changes made after that savepoint are undone while earlier transaction work can remain pending.



\---



\# 🗑️ RELEASE SAVEPOINT



A savepoint can be removed when it is no longer needed.



```sql

RELEASE SAVEPOINT salary\_updated;

```



The transaction itself continues.



\---



\# 🏦 Banking Transfer Example



Consider two accounts:



```text

Account A → ₹10,000

Account B → ₹5,000

```



We want to transfer:



```text

₹2,000

```



Correct transaction logic:



```sql

START TRANSACTION;



UPDATE accounts

SET balance = balance - 2000

WHERE account\_id = 1;



UPDATE accounts

SET balance = balance + 2000

WHERE account\_id = 2;



COMMIT;

```



After a successful transaction:



```text

Account A → ₹8,000

Account B → ₹7,000

```



The total amount remains unchanged.



\---



\# 🚨 Why Transactions Matter



Imagine the first update succeeds:



```text

Account A

₹10,000 → ₹8,000

```



but the second operation fails before Account B receives the money.



Without proper transaction handling, the database could be left inconsistent.



A transaction allows the application to roll back the incomplete operation.



\---



\# 🧪 Testing Changes Safely



Transactions can also help when experimenting with data.



```sql

START TRANSACTION;



UPDATE employees

SET salary = salary \* 1.10;



SELECT \*

FROM employees;



ROLLBACK;

```



This lets us inspect the temporary result and then undo it.



This is useful when learning or testing `UPDATE` and `DELETE` statements.



\---



\# ⚙️ Autocommit



MySQL normally uses autocommit mode.



Check it with:



```sql

SELECT @@autocommit;

```



A result of:



```text

1

```



means autocommit is enabled.



With autocommit enabled, standalone statements are normally committed automatically unless an explicit transaction has been started.



\---



\# 🧱 ACID Properties



Reliable transaction systems are commonly described using \*\*ACID\*\*.



\## A - Atomicity



A transaction behaves as one logical unit.



```text

Everything succeeds

OR

Everything is rolled back

```



\---



\## C - Consistency



A transaction should move the database from one valid state to another while respecting defined constraints and rules.



\---



\## I - Isolation



Concurrent transactions should interact according to the database's configured isolation rules.



The goal is to prevent inappropriate interference between simultaneous operations.



\---



\## D - Durability



After a successful `COMMIT`, committed changes should survive subsequent failures according to the guarantees of the storage engine.



\---



\# 🧠 Transaction Boundaries



A transaction has a beginning and an ending.



```text

START TRANSACTION

&#x20;       ↓

SQL operations

&#x20;       ↓

COMMIT

```



or:



```text

START TRANSACTION

&#x20;       ↓

SQL operations

&#x20;       ↓

ROLLBACK

```



Savepoints create smaller recovery points inside those boundaries.



\---



\# ⚠️ Transactions and Storage Engines



In MySQL, transaction support depends on the storage engine.



`InnoDB` supports transactions and is the standard choice for transactional workloads.



You can inspect table information with:



```sql

SHOW TABLE STATUS;

```



\---



\# ⚠️ DDL and Implicit Commits



Transaction behavior should not be assumed to apply identically to every SQL statement.



In MySQL, many DDL statements such as:



```sql

CREATE TABLE

ALTER TABLE

DROP TABLE

```



can cause implicit commits.



Therefore, transaction practice should primarily use transactional DML operations such as:



```sql

INSERT

UPDATE

DELETE

```



when demonstrating rollback behavior.



\---



\# 🔐 Transaction Safety Pattern



A common application-level pattern is:



```text

Begin transaction

&#x20;      ↓

Validate data

&#x20;      ↓

Perform related operations

&#x20;      ↓

Everything successful?

&#x20;    ↙     ↘

&#x20;  Yes      No

&#x20;   ↓        ↓

&#x20;COMMIT   ROLLBACK

```



The application or stored-program logic usually decides whether to commit or roll back after checking for errors.



\---



\# 🛒 Inventory Example



Suppose a customer purchases a product.



Two operations may be required:



```text

Create order

\+

Reduce inventory

```



These operations belong together.



```sql

START TRANSACTION;



INSERT INTO orders (...);



UPDATE products

SET stock = stock - 1

WHERE product\_id = 101;



COMMIT;

```



If an operation fails, the application can issue:



```sql

ROLLBACK;

```



instead of leaving an incomplete order.



\---



\# 🎯 SAVEPOINT Use Case



Suppose a transaction performs three operations:



```text

Operation A

Operation B

Operation C

```



After B:



```sql

SAVEPOINT after\_operation\_b;

```



If C needs to be undone:



```sql

ROLLBACK TO SAVEPOINT after\_operation\_b;

```



A and B can remain part of the transaction while C is reversed.



\---



\# ⚠️ Important Transaction Practices



When working with transactions:



\- Keep transactions as short as practical

\- Validate critical conditions

\- Avoid leaving transactions open unnecessarily

\- Use `ROLLBACK` when an operation cannot safely continue

\- Use savepoints for controlled partial recovery

\- Be aware of autocommit behavior

\- Understand the storage engine being used

\- Test destructive operations carefully



\---



\# 💼 Real-World Applications



Transactions are essential in:



\- Banking systems

\- Money transfers

\- Payment processing

\- E-commerce orders

\- Inventory management

\- Ticket booking

\- Hotel reservations

\- Payroll systems

\- Accounting software

\- Wallet applications

\- Data migration

\- Financial reporting systems



\---



\# 💻 Practice



Today's exercises include:



\- Starting transactions

\- Committing updates

\- Rolling back updates

\- Rolling back deletes

\- Testing inserts safely

\- Creating savepoints

\- Rolling back to savepoints

\- Releasing savepoints

\- Multi-step transactions

\- Banking transfer simulations

\- Inventory-style operations

\- Checking autocommit

\- Verifying transaction results

\- Using multiple savepoints



All practice queries are available in:



`queries.sql`



\---



\# 🎯 What I Learned



Today I learned how SQL transactions protect related database operations from being partially applied.



`START TRANSACTION` begins a transaction, `COMMIT` permanently saves its changes, and `ROLLBACK` reverses uncommitted work.



I also learned how `SAVEPOINT` creates checkpoints inside a transaction, allowing only part of the transaction to be reversed.



The ACID principles explain the reliability goals behind transaction processing: Atomicity, Consistency, Isolation, and Durability.



Transactions are one of the most important SQL concepts for real-world applications because many business operations involve multiple database changes that must remain logically consistent.



\---



\## 📈 Challenge Progress



\*\*Day 25 / 30 ✅\*\*



Previous: \*\*Day 24 - Indexes \& Query Optimization\*\*



Next: \*\*Day 26 - Stored Procedures \& Parameters\*\*

