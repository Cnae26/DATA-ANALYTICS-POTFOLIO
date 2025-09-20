# 🛒 Supermarket Sales Analysis (SQL + Power BI)

## 📌 Overview
This project analyzes the **Supermarket Sales Dataset (Myanmar)** using **SQL** and visualizes insights in **Power BI**.  
The dataset contains supermarket transactions with details such as branch, product line, customer type, payment method, unit price, quantity, and sales date.

## 🎯 Objectives
- Build SQL queries to answer key business questions
- Create KPIs and insights for management
- Develop an interactive Power BI Dashboard
- Demonstrate end-to-end Data Analysis workflow for portfolio

- ## 🛠 Tools Used
- **SQL (PostgreSQL)** → Data extraction and transformation
- **Power BI** → Dashboard and visualization

---
## 📂 Project Structure

### 1. KPIs
```sql
-- Total Revenue
SELECT SUM("Unit_price" * "Quantity") AS Total_Revenue
FROM "SuperMarketAnalysis";

--- Total Orders
SELECT COUNT(DISTINCT "Invoice_ID") as Total_Order 
FROM "SuperMarketAnalysis"

-- AVG items per Order 
SELECT SUM("Quantity") * 1.0 / COUNT(DISTINCT "Invoice_ID") as Age_Items_per_order 
FROM "SuperMarketAnalysis"
```
## Insight 
- Total revenue =  307587.37
- Total Order = 1000
- Customers buy = 5 items per order.


###  2. Product Analysis
```sql
-- Top 5 Product Lines by Revenue
SELECT "Product_line" ,
		SUM ("total_sale") as "Total_Revenue"
FROM "SuperMarketAnalysis"
GROUP by "Product_line"
ORDER by "Total_Revenue" DESC
LIMIT 5 
```
## Insight 
- Food & Spots and travel  generates the highest revenue , followed by  Eletronic , Fashion Accessories and Hom and lifestyle.

### 3. Customer & Payment Analysis
```sql
--Customer segmentation (high/Low spender)
SELECT "Customer_type",
AVG("total_sale") as Age_spender
FROM "SuperMarketAnalysis"
GROUP by "Customer_type"

SELECT "Payment" , COUNT(*) as Num_transaction , SUM("Unit_price" * "Quantity") as Revenue
FROM "SuperMarketAnalysis"
GROUP by "Payment"
ORDER by 3 DESC

```
## Insight 
- Menber spend more than Nomal customer.
- Cash is the most used payment method.

### 4. Time Analysis 
``` sql
--Peak Sales Hours
SELECT EXTRACT(HOUR FROM "Time"::time) AS Hour,
       SUM("Unit_price" * "Quantity") AS Sale
FROM "SuperMarketAnalysis"
GROUP BY Hour
ORDER BY Sale DESC;
```
## Insight 
- Peak housr are seven o'clock in the evening and one o'clock in the afternoon.
