--This a code for coffee shop analysis

SELECT*FROM transactions.sales.coffee_shop;

 SELECT DISTINCT product_category,product_type
 FROM transactions.sales.coffee_shop;
 
 SELECT
 SUM(transaction_qty*unit_price) AS total_revenue
 FROM transactions.sales.coffee_shop;
 

 ---Transaction period
 SELECT 
    MIN(TO_DATE(transaction_date)) AS min_transaction_period,
    MAX(TO_DATE(transaction_date)) AS max_transaction_period
 FROM transactions.sales.coffee_shop;

 ---Transaction times 
 SELECT MIN(transaction_time) AS first_transaction,
        MAX(transaction_time) AS last_transaction
FROM transactions.sales.coffee_shop;
  
---Total revenue per transaction
SELECT(transaction_qty*unit_price) AS revenue_per_transaction
FROM transactions.sales.coffee_shop;

---Agg
SELECT
   COUNT(transaction_id) AS number_of_sales,
   SUM(transaction_qty*unit_price) AS total_revenue,
   SUM(transaction_qty) AS number_of_units_sold,

---Groups   
   store_location,
   product_category,
   product_type,
   product_detail,

---Transaction dates
   TO_DATE(transaction_date) AS purchase_date,
   TO_CHAR(TO_DATE(transaction_date),'YYYYMM') AS month_id,
   MONTHNAME(TO_DATE(transaction_date)) AS transaction_month,
   DAYNAME(TO_DATE(transaction_date)) AS day_of_week,
   
---Time(flagging time) 

CASE
    WHEN transaction_time  BETWEEN '06:00:00' AND '11:59:59' THEN 'breakfast_time'
    WHEN transaction_time  BETWEEN '12:00:00' AND '14:00:00' THEN 'lunch_time'   
ELSE 'after_hours'
END AS serving_time,

CASE
    WHEN SUM(transaction_qty*unit_price) BETWEEN 0 AND 25 THEN 'low'
    WHEN SUM(transaction_qty*unit_price)  BETWEEN 26 AND 45 THEN 'Med' 
    WHEN SUM(transaction_qty*unit_price)  BETWEEN 46 AND 65 THEN 'high'
ELSE 'very high'
END AS spent_band

FROM transactions.sales.coffee_shop
GROUP BY 
   store_location,
   product_category,
   product_type,
   product_detail,
   purchase_date,
   month_id,
   transaction_month,
   serving_time,
   day_of_week;
