

-- Count the custromer base based on custromer type to identify current. custromer perferences and sort them in desending order. 

 
SELECT COUNT ("Customer"."C_ID") as coustromer_count,
 		"Customer"."C_TYPE"
        FROM "Customer"
        GROUP BY "Customer"."C_TYPE"
        ORDER BY "coustromer_count" DESC  ;


        
 SELECT * FROM "Payment_Details"
 
 SELECT * FROM "Customer"
 
 
-- Count the custromer base based on their status of payment in descendingoder
 SELECT COUNT(cs.c1) AS  coustromer_count,
 	py.c5 as Payment_Details
 FROM "Customer" as cs
 INNER JOIN "Payment_Details" as py
 ON cs.c1 = py.c2
 GROUP BY py.c5
 ORDER BY coustromer_count DESC 
 
 --Count the custromer base based on their payment in desending order of count.
SELECT COUNT(c.c1) as coustromer_count,
	p.c6 as payment_mode
FROM "Customer" as c
INNER JOIN "Payment_Details" as p 
on c.c1 = p.c2 
group BY p.c6
ORDER BY coustromer_count DESC
 
-- Count the customers as per shipment domain in descending order.
 SELECT * FROM "Shipment_Details"
 
 SELECT COUNT(c.c1) as custromer_count,
 	SM.c4 as shipmeant_domain
 FROM "Customer" as c 
 INNER JOIN "Shipment_Details" as SM
 ON c.c1 = SM.c2
 GROUP BY SM.c4
 ORDER BY  custromer_count DESC;
 
 -- Count the customer according to service type in descending order of count
 
 SELECT * FROM "Shipment_Details"
 
 SELECT COUNT(c.c1) as custromer_count,
 	SM.c5 as shipmeant_service_type
 FROM "Customer" as c 
 INNER JOIN "Shipment_Details" as SM
 ON c.c1 = SM.c2
 GROUP BY SM.c5
 ORDER BY  custromer_count DESC;
 
-- Explore employee count based on the disingnation - wise count of employees IDs in descending order 

SELECT * FROM "Employee_Details"

SELECT COUNT("Employee_Details".c1) as employee_count ,
	"Employee_Details".c3 AS Derparment
FROM  "Employee_Details" 
GROUP by Derparment
ORDER BY employee_count  DESC; 

SELECT 
	CASE
    WHEN "Employee_Details".c3 is NULL THEN 'Total Employee'
    ELSE "Employee_Details".c3
    END as Department,
    COUNT("Employee_Details".c1) as employee_count
FROM "Employee_Details"
GROUP by  ROLLUP("Employee_Details".c3)
order by CASE WHEN "Employee_Details".c3 is NULL THEN 0 ELSE 1 END,
	employee_count DESC
  
 -- Branch-wise count of employees for efficiency of deliveries in descending order.
 
 SELECT COUNT("Employee_Details".c1) as employee_count ,
	"Employee_Details".c5 AS employee_branch
FROM  "Employee_Details" 
GROUP by employee_branch
ORDER BY employee_count  DESC;

SELECT * FROM "Membership"

SELECT * FROM "Customer"


-- Finding C_ID, M_ID, and tenure for those customers whose membership is over 10 years

-- data_type
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'Membership';


DELETE FROM "Membership"
WHERE "Membership".c2 = 'Start_date';

DROP TABLE "Membership"

ALTER TABLE "Membership"
ALTER COLUMN "Start_date" TYPE DATE
USING TO_DATE("Start_date", 'YYYY-MM-DD');

ALTER TABLE "Membership"
ALTER COLUMN "End_date" TYPE DATE
USING TO_DATE("End_date", 'YYYY-MM-DD');


SELECT * FROM "Customer"
SELECT * FROM "Membership"


SELECT  ct."M_ID" as membership_id,
    ct."C_ID" as custromer_id,
    ct."C_NAME" as custromer_name,
    mb."Start_date",
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, mb."Start_date")) AS tenure_year
FROM "Membership" AS mb
INNER JOIN "Customer" AS ct
    ON mb."M_ID" = ct."M_ID"
WHERE 
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, mb."Start_date")) > 10;


DROP TABLE "Payment_Details"
--Comsidering average payment amount based on custromer type having payment mode as COD in descending order   

SELECT  AVG(py."AMOUNT") as avg_payment,
		"Payment_Mode",
        ct."C_TYPE"
FROM "Payment_Details" as py
INNER JOIN "Customer" as ct 
on py."C_ID" = ct."C_ID"
WHERE py."Payment_Mode" ='COD'
GROUP BY "Payment_Mode" , ct."C_TYPE"
ORDER by avg_payment DESC 


-- Calculate the average payment amount based on payment mode where the payment date is not null.

SELECT * FROM "Payment_Details"

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'Payment_Details';

ALTER TABLE "Payment_Details"
ALTER COLUMN "Payment_Date" TYPE DATE
USING TO_DATE("Payment_Date", 'YYYY-MM-DD');

SELECT ROUND(avg("AMOUNT"),2) as ang_amount,
	"Payment_Mode",
    "Payment_Date"
FROM "Payment_Details"
WHERE "Payment_Date" IS NOT NULL
GROUP by "Payment_Mode","Payment_Date"
ORDER BY "Payment_Date"

-- Calculate the average shipment weight based on payment_status where shipment content does not start with "H."
DROP TABLE "Shipment_Details"

SELECT round(avg("SH_WEIGHT") ,2) as avg_weight_shipment,
		"Payment_Status"
FROM "Shipment_Details" as sm
INNER JOIN "Payment_Details" as py
on py."SH_ID" = sm."SH_ID"
WHERE SM."SH_CONTENT"  not LIKE 'H%'
GROUP BY py."Payment_Status"

-- 12. Retrieve the names and designations of all employees in the 'NY' E_Branch.

SELECT * FROM "Employee_Details"

SELECT "E_NAME",
		"E_DESIGNATION",
        "E_BRANCH"
FROM "Employee_Details"
WHERE "E_BRANCH" = 'NY'

-- 13. Calculate the total number of customers in each C_TYPE (Wholesale, Retail, Internal Goods).

SELECT * FROM "Customer"

SELECT COUNT("C_ID") AS count_custromer_id,
		"C_TYPE"
FROM "Customer"
GROUP BY "C_TYPE"
ORDER BY count_custromer_id DESC

-- 14. Find the membership start and end dates for customers with 'Paid' payment status

SELECT MB."M_ID" , 
		MB."Start_date",
        MB."End_date",
        PM."Payment_Status"
FROM "Membership" AS MB 
LEFT JOIN "Customer" AS CS
ON cs."M_ID" = mb."M_ID"
INNER JOIN "Payment_Details" AS PM
ON CS."C_ID" = PM."C_ID"
WHERE PM."Payment_Status" = 'PAID'

-- 15. List the clients who have made 'Card Payment' and have a 'Regular' service type.

SELECT ct."C_ID",
		ct."C_NAME",
        pm."Payment_Mode",
        sm."SER_TYPE"
FROM "Customer" AS CT
INNER JOIN "Payment_Details" AS PM 
ON CT."C_ID" = PM."C_ID" 
INNER JOIN "Shipment_Details" AS SM
ON CT."C_ID" = SM."C_ID" 
WHERE SM."SER_TYPE" = 'Regular' AND PM."Payment_Mode" = 'CARD PAYMENT'

SELECT * FROM "Payment_Details" 
WHERE "Payment_Mode" =  'CARD PAYMENT'

-- 16. Calculate the average shipment weight for each shipment domain (International and Domestic).

SELECT * FROM "Shipment_Details"


SELECT ROUND(avg("SH_WEIGHT"), 2) AS AVG_WEIGHT ,
		"SH_DOMAIN"
FROM "Shipment_Details"
GROUP by "SH_DOMAIN"

-- 17. Identify the shipment with the highest charges and the corresponding client's name.

SELECT  CT."C_ID",
        CT."C_NAME",
        SM."SH_CHARGES"
FROM "Shipment_Details" as SM
LEFT JOIN "Customer" AS CT
ON ct."C_ID" = sm."C_ID" 
ORDER by  SM."SH_CHARGES" DESC 
LIMIT 1

SELECT * FROM "Shipment_Details" as sm
order by sm."SH_CHARGES" DESC  

-- 18. Count the number of shipments with the 'Express' service type that are yet to be delivered

SELECT * FROM "Shipment_Details"
SELECT * FROM "Status"

SELECT  COUNT(sm."SH_ID") AS Total_shipment,
		sm."SER_TYPE",
        st."Current_Status"
FROM "Shipment_Details" as sm
LEFT JOIN "Status" as st
ON sm."SH_ID" = st."SH_ID" 
WHERE sm."SER_TYPE" = 'Express'and st."Current_Status" = 'NOT DELIVERED'
GROUP BY sm."SER_TYPE", st."Current_Status"

-- 19. List the clients who have 'Not Paid' payment status and are based in 'CA'

SELECT CT."C_NAME" ,
		PM."Payment_Status",
        ED."E_BRANCH"
FROM "Customer" as CT
LEFT JOIN "Payment_Details" as PM	
ON CT."C_ID" = PM."C_ID"
INNER JOIN "Shipment_Details" as SM
on SM."SH_ID" = pm."SH_ID" 
INNER JOIN "employee_manages_shipment" as EM
on EM."Shipment_Sh_ID" = SM."SH_ID"
INNER JOIN "Employee_Details" AS ED
ON ED."E_ID" = EM."Employee_E_ID"
WHERE  ED."E_BRANCH" = 'CA' AND PM."Payment_Status" = 'NOT PAID'


-- 20. Retrieve the current status and delivery date of shipments managed by employees with the designation 'Delivery Boy'.
SELECT COUNT("E_ID") 
FROM "Employee_Details" 
WHERE "E_DESIGNATION" = 'Delivery Boy'


SELECT ST."Current_Status",
		ST."Sent_date",
        ED."E_NAME",
        ED."E_DESIGNATION"
FROM "Shipment_Details" as SM 
LEFT JOIN "Status" as ST
ON SM."SH_ID" = ST."SH_ID"
INNER JOIN "employee_manages_shipment" AS EM
ON EM."Shipment_Sh_ID" = ST."SH_ID"
INNER JOIN "Employee_Details" AS ED 
ON ED."E_ID" = EM."Employee_E_ID"
WHERE ED."E_DESIGNATION"  = 'Delivery Boy' AND ST."Current_Status" = 'DELIVERED'
ORDER BY  ST."Sent_date" DESC

-- 21. Find the membership start and end dates for customers whose 'Current Status' is 'Not Delivered'.
SELECT MB."M_ID" ,
		MB."Start_date",
        MB."End_date",
        ST."Current_Status"
FROM "Membership" AS MB
LEFT JOIN "Customer" AS CT
ON CT."M_ID" = MB."M_ID"
INNER JOIN "Shipment_Details" AS SD 
ON SD."C_ID" = CT."C_ID"
INNER JOIN "Status" as ST
ON ST."SH_ID" = SD."SH_ID"
WHERE ST."Current_Status" = 'NOT DELIVERED'
```






