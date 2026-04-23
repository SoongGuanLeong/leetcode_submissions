# Write your MySQL query statement below
SELECT customer_name, customer_id, order_id, order_date
FROM
    (SELECT name AS customer_name, o.customer_id, order_id, order_date,
        ROW_NUMBER()OVER(PARTITION BY o.customer_id ORDER BY order_date DESC) AS rnk
    FROM Orders o JOIN Customers c
    ON o.customer_id = c.customer_id) AS t1
WHERE rnk <= 3
ORDER BY customer_name, customer_id, order_date DESC