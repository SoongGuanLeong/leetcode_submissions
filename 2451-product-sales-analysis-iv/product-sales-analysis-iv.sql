-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT 
        COALESCE(s.product_id, p.product_id) AS product_id,
        user_id,
        SUM(price * quantity) AS total_revenue,
        RANK() OVER(PARTITION BY user_id ORDER BY SUM(price * quantity) DESC) AS rnk
    FROM Sales s LEFT JOIN Product p
    ON s.product_id = p.product_id
    GROUP BY 2, 1
)
SELECT user_id, product_id
FROM A
WHERE rnk = 1
