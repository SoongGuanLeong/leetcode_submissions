# Write your MySQL query statement below
SELECT o.customer_id, customer_name
FROM Customers c, Orders o
WHERE c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING 
    SUM(product_name = "A") > 0
    AND SUM(product_name = "B") > 0
    AND SUM(product_name = "C") = 0
