# Write your MySQL query statement below
SELECT c.customer_id, name
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
JOIN Product p
ON p.product_id = o.product_id
WHERE YEAR(order_date) = 2020
GROUP BY c.customer_id
HAVING SUM(IF(MONTH(order_date) = 6, quantity, 0) * price) >= 100
AND SUM(IF(MONTH(order_date) = 7, quantity, 0) * price) >= 100