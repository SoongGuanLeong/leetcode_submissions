-- Write your PostgreSQL query statement below
SELECT 
    user_id,
    SUM(quantity * price) AS spending
FROM Sales s
JOIN Product p
ON s.product_id = p.product_id
GROUP BY 1
ORDER BY 2 DESC, 1