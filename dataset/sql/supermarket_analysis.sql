SELECT * FROM "SuperMarketAnalysis"

-- Total Revenue 
SELECT SUM("Unit_price" * "Quantity") as Total_Revenue 
FROM "SuperMarketAnalysis"

--- Total Orders
SELECT COUNT(DISTINCT "Invoice_ID") as Total_Order 
FROM "SuperMarketAnalysis"

-- Sales by Branch
SELECT "Branch" , SUM("Unit_price" * "Quantity") as Total_sales
FROM "SuperMarketAnalysis"
GROUP by "Branch" 
ORDER by Total_sales DESC

--Top 5 Product Lines
SELECT "Product_line" , ROUND(CAST(SUM("Unit_price" * "Quantity")AS NUMERIC), 2) as Revenue 
FROM "SuperMarketAnalysis"
GROUP by "Product_line"
order by Revenue DESC 
LIMIT 5 


-- Sales by Payment Method
SELECT "Payment" , COUNT(*) as Num_transaction , SUM("Unit_price" * "Quantity") as Revenue
FROM "SuperMarketAnalysis"
GROUP by "Payment"
ORDER by 3 DESC

--Peak Sales Hours
SELECT EXTRACT(HOUR FROM "Time"::time) AS Hour,
       SUM("Unit_price" * "Quantity") AS Sale
FROM "SuperMarketAnalysis"
GROUP BY Hour
ORDER BY Sale DESC;

--Daily Sale Trend
SELECT "Date",
SUM("total_sale") as Daily_sale
FROm "SuperMarketAnalysis"
GROUP by "Date"
ORDER by  "Date"

--Month Sale Trend
SELECT DATE_TRUNC('month', "Date"::date) AS Month,
       SUM("Unit_price" * "Quantity") AS Monthly_Sales
FROM "SuperMarketAnalysis"
GROUP BY Month
ORDER BY Month;

--Sales by Customer Type
SELECT "Customer_type", SUM("Unit_price" * "Quantity") as Total_sale 
FROM "SuperMarketAnalysis"
GROUP by "Customer_type"

-- % of sale by Products 
ALTER TABLE "SuperMarketAnalysis"
add COLUMN  Total_sale NUMERIC

UPDATE "SuperMarketAnalysis"
SET "total_sale" = "Unit_price" * "Quantity"


SELECT "Product_line",
       SUM("total_sale") AS "Total_Revenue", 
       SUM("total_sale") * 100.0 / (SELECT SUM("total_sale") 
                                  FROM "SuperMarketAnalysis") AS "Percentage"
FROM "SuperMarketAnalysis"
GROUP BY "Product_line"
ORDER BY "Total_Revenue" DESC;

--% of Sales by Customer Type
SELECT "Customer_type",
	SUM("total_sale") as "Total_Revenue",
	SUM("total_sale")  * 100.0/ (SELECT sum("total_sale") FROM "SuperMarketAnalysis") as Percentage
FROM "SuperMarketAnalysis"
GROUP by "Customer_type"

-  Top & Bottom Analysis
-- Top 5 Product Lines by Revenue
SELECT "Product_line" ,
		SUM ("total_sale") as "Total_Revenue"
FROM "SuperMarketAnalysis"
GROUP by "Product_line"
ORDER by "Total_Revenue" DESC
LIMIT 5 

-- Bottom 5 Product Lines by Revenue
SELECT "Product_line" ,
		SUM ("total_sale") as "Total_Revenue"
FROM "SuperMarketAnalysis"
GROUP by "Product_line"
ORDER by "Total_Revenue" ASC
LIMIT 5 

-- Top 5 Branches by Sales
SELECT "Branch" ,
		SUM ("total_sale") as "Total_Revenue"
FROM "SuperMarketAnalysis"
GROUP by "Branch"
ORDER by "Total_Revenue" DESC
LIMIT 5 


-- Top 5 Cities by Sales
SELECT "City" ,
		SUM ("total_sale") as "Total_Revenue"
FROM "SuperMarketAnalysis"
GROUP by "City"
ORDER by "Total_Revenue" DESC
LIMIT 5 

-- AVG items per Order 
SELECT SUM("Quantity") * 1.0 / COUNT(DISTINCT "Invoice_ID") as Age_Items_per_order 
FROM "SuperMarketAnalysis"

--Customer segmentation (high/Low spender)
SELECT "Customer_type",
AVG("total_sale") as Age_spender
FROM "SuperMarketAnalysis"
GROUP by "Customer_type" 
