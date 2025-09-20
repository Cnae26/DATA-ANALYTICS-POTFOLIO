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

-- Average Order Value
SELECT SUM("Unit_price" * "Quantity") / COUNT(DISTINCT "Invoice_ID") AS Avg_Order_Value
FROM "SuperMarketAnalysis";

-- Average Items per Order
SELECT SUM("Quantity") * 1.0 / COUNT(DISTINCT "Invoice_ID") AS Avg_Items_per_Order
FROM "SuperMarketAnalysis";
```
