# Write your MySQL query statement below
SELECT a.product_id, IFNULL(ROUND((SUM(price*units)/SUM(units)),2),0) AS average_price
FROM Prices a LEFT JOIN UnitsSold b
ON a.product_id = b.product_id

AND purchase_date BETWEEN start_date AND end_date

GROUP BY a.product_id