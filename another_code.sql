SELECT*FROM transactions.sales.coffee_shop;

 SELECT DISTINCT product_category,product_type
 FROM transactions.sales.coffee_shop;
 
 SELECT
 SUM(transaction_qty*unit_price) AS total_revenue
 FROM transactions.sales.coffee_shop;