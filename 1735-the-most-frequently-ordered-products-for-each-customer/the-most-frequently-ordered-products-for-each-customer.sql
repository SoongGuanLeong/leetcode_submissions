# Write your MySQL query statement below
SELECT customer_id, product_id, product_name
FROM
    (SELECT customer_id, o.product_id, product_name,
    RANK()OVER(PARTITION BY customer_id ORDER BY COUNT(o.product_id) DESC) AS rnk
    FROM Orders o JOIN Products p
    ON o.product_id = p.product_id
    GROUP BY customer_id, product_id) AS t1
WHERE rnk = 1