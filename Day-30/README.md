\# 🏆 Day 30 - Final SQL Capstone Project



\## E-Commerce Customer Analytics \& Retention Intelligence



Welcome to \*\*Day 30 of my 30 Days of SQL Challenge!\*\*



Today marks the final day of my SQL learning challenge.



Over the previous 29 days, I explored SQL fundamentals, advanced querying, analytical functions, database optimization, transactions, stored procedures, triggers, and data integrity.



For the final day, I developed an end-to-end SQL analytics project that simulates a real-world e-commerce business.



Instead of focusing on isolated SQL commands, this project demonstrates how SQL can transform transactional data into meaningful business insights.



The project introduces two important analytical techniques:



1\. \*\*Cohort Retention Analysis\*\*

2\. \*\*RFM Customer Segmentation\*\*



These techniques are widely used in customer analytics, business intelligence, and data-driven marketing.



\---



\# 📌 Project Overview



\*\*Project Name:\*\* E-Commerce Customer Analytics \& Retention Intelligence



\*\*Database:\*\* MySQL 8.0+



\*\*Domain:\*\* E-Commerce / Retail Analytics



\*\*Project Type:\*\* SQL Data Analytics Capstone



\*\*Difficulty:\*\* Intermediate to Advanced



\*\*Primary Objective:\*\*



Analyze customer purchasing behavior, identify valuable customer segments, measure retention, and generate actionable business recommendations.



\---



\# 🎯 Business Problem



An e-commerce company wants to understand its customers and improve business performance.



The management team needs answers to several important questions:



\- How much revenue is the business generating?

\- Which products and categories generate the most revenue?

\- Who are the highest-value customers?

\- How frequently do customers make purchases?

\- Which customers have stopped purchasing?

\- How many customers return after their first purchase?

\- Which customer groups should receive retention campaigns?

\- How can customers be segmented based on purchasing behavior?



This project addresses these questions using SQL.



\---



\# 🗂️ Database Architecture



The project uses four related tables.



```text

&#x20;                   CUSTOMERS

&#x20;                       |

&#x20;                       | customer\_id

&#x20;                       |

&#x20;                     ORDERS

&#x20;                       |

&#x20;                       | order\_id

&#x20;                       |

&#x20;                   ORDER\_ITEMS

&#x20;                       |

&#x20;                       | product\_id

&#x20;                       |

&#x20;                    PRODUCTS

```



\## 1. Customers



Stores customer information.



Important columns:



\- customer\_id

\- customer\_name

\- city

\- signup\_date



\## 2. Products



Stores product information.



Important columns:



\- product\_id

\- product\_name

\- category

\- list\_price



\## 3. Orders



Stores customer orders.



Important columns:



\- order\_id

\- customer\_id

\- order\_date

\- order\_status



\## 4. Order Items



Stores products purchased within each order.



Important columns:



\- order\_item\_id

\- order\_id

\- product\_id

\- quantity

\- unit\_price

\- discount\_percent



The `unit\_price` column stores the price at the time of purchase, allowing historical revenue to remain accurate even if product prices change later.



\---



\# 🛠️ Technologies Used



| Technology | Purpose |

|---|---|

| MySQL 8.0+ | Relational database |

| SQL | Data querying and analysis |

| MySQL Workbench | Database development |

| Git | Version control |

| GitHub | Project documentation |



\---



\# 🧠 New Concept 1: Cohort Analysis



Cohort analysis groups customers based on a shared characteristic.



In this project, customers are grouped according to the month of their first completed purchase.



For example:



```text

January Cohort

&#x20;   |

&#x20;   +--- Customers who first purchased in January

&#x20;   |

&#x20;   +--- Returned in February?

&#x20;   |

&#x20;   +--- Returned in March?

&#x20;   |

&#x20;   +--- Returned in April?

```



This allows businesses to understand whether customers continue purchasing after their initial order.



\---



\# 📊 Cohort Retention Rate



Customer retention measures the percentage of customers who return during a particular period.



Formula:



```text

Retention Rate =



Customers from a cohort active in a given month

\------------------------------------------------ × 100

Total customers in the original cohort

```



Example:



Suppose 100 customers made their first purchase in January.



Of those customers:



\- 40 purchased again in February.

\- 25 purchased again in March.

\- 20 purchased again in April.



The retention rates would be:



| Month | Active Customers | Retention |

|---|---:|---:|

| Month 0 | 100 | 100% |

| Month 1 | 40 | 40% |

| Month 2 | 25 | 25% |

| Month 3 | 20 | 20% |



Month 0 represents the customer's first purchase month.



Retention is calculated independently for each month. A customer does not need to purchase in every preceding month to count as retained in a later month.



\---



\# 📅 Cohort Month Calculation



The first completed purchase determines the customer's cohort.



Example:



```sql

SELECT

&#x20;   customer\_id,

&#x20;   MIN(order\_date) AS first\_purchase\_date

FROM d30\_orders

WHERE order\_status = 'COMPLETED'

GROUP BY customer\_id;

```



The first purchase date can then be converted into a monthly cohort.



```sql

DATE\_FORMAT(first\_purchase\_date, '%Y-%m')

```



\---



\# 🔢 Months Since First Purchase



To measure retention, we calculate the difference between the cohort month and each subsequent purchase month.



Example:



```sql

TIMESTAMPDIFF(

&#x20;   MONTH,

&#x20;   cohort\_month,

&#x20;   purchase\_month

)

```



Possible results:



```text

0 → First purchase month

1 → Following month

2 → Two months later

3 → Three months later

```



The analysis uses the first day of each calendar month to ensure accurate monthly comparisons.



\---



\# 🧠 New Concept 2: RFM Analysis



RFM stands for:



\*\*R - Recency\*\*



\*\*F - Frequency\*\*



\*\*M - Monetary Value\*\*



RFM is a customer segmentation technique that analyzes purchasing behavior.



It helps identify customers who are:



\- Highly valuable

\- Frequent buyers

\- Recently active

\- Becoming inactive

\- Potentially at risk of leaving



\---



\# 🕒 R - Recency



Recency measures how recently a customer purchased.



Formula:



```text

Recency = Analysis Date - Last Purchase Date

```



Example:



```text

Customer A → Last purchased 5 days ago



Customer B → Last purchased 60 days ago

```



Customer A has better recency because they purchased more recently.



Lower recency values generally indicate more recent activity.



\---



\# 🔄 F - Frequency



Frequency measures how many completed orders a customer has placed.



Formula:



```text

Frequency = Number of Completed Orders

```



Example:



```text

Customer A → 8 Orders



Customer B → 2 Orders

```



Customer A has a higher purchase frequency.



\---



\# 💰 M - Monetary Value



Monetary value measures how much revenue a customer has generated.



Formula:



```text

Monetary Value = Total Completed Purchase Revenue

```



Example:



```text

Customer A → ₹50,000



Customer B → ₹8,000

```



Customer A has a higher monetary value.



This project calculates revenue after item-level discounts.



Cancelled and pending orders are excluded from recognized revenue.



\---



\# 📈 RFM Scoring



Customers receive scores from 1 to 5 for each RFM dimension.



| Score | Interpretation |

|---|---|

| 5 | Highest relative score |

| 4 | High |

| 3 | Medium |

| 2 | Low |

| 1 | Lowest relative score |



Example:



| Customer | R | F | M |

|---|---:|---:|---:|

| Customer A | 5 | 5 | 5 |

| Customer B | 4 | 3 | 4 |

| Customer C | 1 | 2 | 5 |

| Customer D | 2 | 1 | 1 |



A customer with scores of:



```text

R = 5

F = 5

M = 5

```



is among the strongest customers across all three dimensions.



This project uses `NTILE(5)` for relative scoring.



Because the demonstration dataset is small, customers with equal values may receive different scores when they fall across bucket boundaries.



For production systems, percentile thresholds or business-defined scoring bands may provide more stable segmentation.



\---



\# 🏷️ Customer Segmentation



Based on RFM scores, customers are assigned business-friendly segments.



\## Champions



Customers with strong recency, frequency, and monetary scores.



These customers are highly valuable and actively engaged.



\*\*Recommended Action:\*\*



Provide loyalty rewards, exclusive benefits, and early access to products.



\---



\## Loyal Customers



Customers who purchase frequently and remain relatively active.



\*\*Recommended Action:\*\*



Introduce referral programs, personalized offers, and loyalty incentives.



\---



\## At-Risk High-Value Customers



Customers with historically strong spending but relatively poor recency.



\*\*Recommended Action:\*\*



Launch personalized reactivation campaigns and investigate why purchasing activity has declined.



\---



\## Recent Customers



Customers who purchased recently but have not yet established frequent purchasing behavior.



\*\*Recommended Action:\*\*



Encourage a second purchase through onboarding campaigns and relevant recommendations.



\---



\## Developing Customers



Customers who do not yet fall into the other segments.



\*\*Recommended Action:\*\*



Use personalized marketing to encourage additional purchases and improve engagement.



\---



\# 🧮 Revenue Calculation



Revenue is calculated from individual order items.



Formula:



```text

Line Revenue =



Quantity × Unit Price × (1 - Discount Percentage / 100)

```



Example:



```text

Quantity = 2



Unit Price = ₹1,000



Discount = 10%

```



Calculation:



```text

2 × 1000 × (1 - 10/100)



= ₹1,800

```



Order revenue is the sum of its line-item revenue.



Only completed orders contribute to recognized revenue.



\---



\# 📊 Key Business Metrics



The project calculates several important KPIs.



\## 1. Total Revenue



Total revenue generated from completed orders.



\## 2. Completed Orders



Number of successfully completed purchases.



\## 3. Average Order Value



```text

AOV = Total Revenue / Completed Orders

```



\## 4. Purchasing Customers



Number of distinct customers with at least one completed order.



\## 5. Repeat Purchase Rate



```text

Repeat Purchase Rate =



Customers with at least 2 completed orders

\------------------------------------------ × 100

Customers with at least 1 completed order

```



\## 6. Customer Lifetime Revenue



Total completed-order revenue generated by each customer during the available observation period.



This is observed historical revenue, not a prediction of future customer lifetime value.



\## 7. Cohort Retention



Percentage of customers returning in subsequent months.



\## 8. RFM Segmentation



Classification of customers based on recency, frequency, and monetary value.



\---



\# 🏗️ Project Workflow



```text

&#x20;                START

&#x20;                  |

&#x20;                  v

&#x20;          Create Database Tables

&#x20;                  |

&#x20;                  v

&#x20;           Insert Sample Data

&#x20;                  |

&#x20;                  v

&#x20;          Validate Data Quality

&#x20;                  |

&#x20;                  v

&#x20;         Build Order Revenue View

&#x20;                  |

&#x20;                  v

&#x20;        Calculate Business KPIs

&#x20;                  |

&#x20;                  v

&#x20;         Analyze Monthly Revenue

&#x20;                  |

&#x20;                  v

&#x20;        Analyze Customer Behavior

&#x20;                  |

&#x20;                  v

&#x20;        Perform Cohort Analysis

&#x20;                  |

&#x20;                  v

&#x20;         Calculate RFM Scores

&#x20;                  |

&#x20;                  v

&#x20;         Segment the Customers

&#x20;                  |

&#x20;                  v

&#x20;      Generate Business Recommendations

&#x20;                  |

&#x20;                  v

&#x20;                 END

```



\---



\# 🧱 Reusable Analytical Views



The project creates three reusable views.



\### d30\_order\_facts



Calculates order-level revenue from order items.



\### d30\_customer\_value



Calculates completed-order frequency, lifetime revenue, and most recent completed purchase for each customer.



\### d30\_rfm\_scores



Assigns relative RFM scores to purchasing customers.



These views help separate data preparation from business analysis.



\---



\# 🔍 Business Questions Answered



The SQL queries answer:



1\. What is the total revenue?

2\. How many orders were completed?

3\. What is the average order value?

4\. Which months generated the most revenue?

5\. How is revenue changing month over month?

6\. Which product categories perform best?

7\. Which customers generate the most revenue?

8\. What percentage of customers make repeat purchases?

9\. How are orders distributed across statuses?

10\. How many customers return after their first purchase?

11\. Which cohorts have the strongest retention?

12\. Which customers are Champions?

13\. Which valuable customers are at risk?

14\. Which customers should receive retention campaigns?

15\. Are order-level revenue calculations consistent?



\---



\# 🧪 Data Quality Validation



Before generating business insights, the project validates:



\- Customer relationships

\- Product relationships

\- Order-item relationships

\- Order statuses

\- Quantity values

\- Discount percentages

\- Completed-order revenue

\- Customers without purchases



Database constraints help prevent invalid records.



Additional analytical checks help identify unexpected business conditions.



\---



\# 📌 Important Analytical Assumptions



The project uses the following assumptions:



1\. Only `COMPLETED` orders contribute to recognized revenue.

2\. Cancelled and pending orders are excluded from customer purchasing metrics.

3\. Discounts are applied at the order-item level.

4\. Historical item prices are used for revenue calculations.

5\. Customer cohorts are based on the first completed purchase.

6\. Cohort retention measures activity within calendar months.

7\. RFM analysis uses October 1, 2026, as a fixed reference date.

8\. Customers without completed purchases are excluded from RFM scoring.

9\. All financial values use the same assumed currency, INR.

10\. The dataset is synthetic and created for educational purposes.



The fixed analysis date ensures that results remain reproducible when the project is executed later.



\---



\# 💼 Business Recommendations



\## Recommendation 1: Retain High-Value Customers



Identify Champions and Loyal Customers.



Offer loyalty benefits and personalized recommendations to maintain engagement.



\## Recommendation 2: Recover At-Risk Customers



Identify customers with high historical spending but low recent activity.



Target them with personalized reactivation campaigns.



\## Recommendation 3: Improve Repeat Purchases



Measure the percentage of customers making a second purchase.



Use onboarding campaigns and post-purchase engagement to encourage repeat orders.



\## Recommendation 4: Monitor Cohort Retention



Track how retention changes across customer acquisition months.



Investigate cohorts showing unusually low repeat activity.



\## Recommendation 5: Optimize Product Strategy



Identify categories generating the most revenue.



Use these insights to support merchandising, marketing, and inventory decisions.



\---



\# ⚠️ Project Limitations



This is an educational analytics project using a small synthetic dataset.



Important limitations include:



\- No real customer information

\- No payment gateway integration

\- No shipping or fulfillment cost data

\- No profit-margin calculations

\- No marketing acquisition cost data

\- No predictive churn model

\- No statistically validated marketing experiments

\- Small customer counts may make retention percentages unstable

\- RFM scores are relative to the sample population



The project demonstrates analytical methodology rather than production-scale business performance.



\---



\# 🚀 Future Improvements



Potential improvements include:



\- Connecting a larger real-world dataset

\- Building an interactive Power BI dashboard

\- Adding customer acquisition channels

\- Tracking marketing campaign performance

\- Creating customer churn prediction models

\- Forecasting monthly revenue

\- Calculating customer acquisition cost

\- Estimating customer lifetime value

\- Automating analytical reporting



\---



\# 🎯 Skills Demonstrated



This capstone demonstrates practical experience with:



\- Relational database design

\- SQL analytics

\- Data quality validation

\- Business KPI development

\- Customer behavior analysis

\- Revenue analysis

\- Customer segmentation

\- Cohort retention analysis

\- Analytical data modeling

\- Reusable SQL views

\- Window-based scoring

\- Business problem solving

\- Translating data into recommendations



\---



\# 🏁 Final Reflection



Completing the 30 Days of SQL Challenge has strengthened my understanding of SQL, from basic database operations to advanced analytical techniques.



Throughout this challenge, I learned how to retrieve, filter, aggregate, transform, and analyze relational data.



I also explored database optimization, reusable SQL logic, transactions, triggers, and data integrity.



The final capstone brings these skills together through a practical business analytics problem.



Most importantly, this challenge helped me understand that SQL is not only a language for retrieving information.



It is a powerful tool for discovering patterns, measuring business performance, and supporting data-driven decisions.



The knowledge gained from this challenge provides a foundation for further learning in:



\- Data Analytics

\- Business Intelligence

\- Data Engineering

\- Database Development

\- Machine Learning Data Preparation



\---



\## 📈 Challenge Progress



\*\*Day 30 / 30 - Final Capstone 🏁\*\*



Previous: \*\*Day 29 - Constraints \& Advanced Data Integrity\*\*



Challenge Status: \*\*Final Project In Progress\*\*



Once completed, this project will mark the successful conclusion of my 30 Days of SQL Challenge.



\---



\*\*Author:\*\* Bhavesh Pawar



\*\*Challenge:\*\* 30 Days of SQL



\*\*Final Project:\*\* E-Commerce Customer Analytics \& Retention Intelligence

