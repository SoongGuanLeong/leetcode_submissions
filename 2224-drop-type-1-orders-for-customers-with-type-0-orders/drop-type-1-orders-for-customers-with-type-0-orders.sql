-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT customer_id, 
        SUM(CASE WHEN order_type = 0 THEN 1 ELSE 0 END) AS zero_count
    FROM Orders
    GROUP BY 1
)
SELECT 
    order_id,
    COALESCE(A.customer_id, o.customer_id) AS customer_id,
    order_type
FROM A JOIN Orders o
ON A.customer_id = o.customer_id
WHERE order_type = 0
UNION ALL
SELECT 
    order_id,
    COALESCE(A.customer_id, o.customer_id) AS customer_id,
    order_type
FROM A JOIN Orders o
ON A.customer_id = o.customer_id
WHERE order_type = 1 AND zero_count = 0