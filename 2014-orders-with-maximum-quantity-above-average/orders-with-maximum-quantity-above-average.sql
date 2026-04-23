-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT order_id,
        AVG(quantity) AS avg_quantity,
        MAX(quantity) AS max_quantity
    FROM OrdersDetails
    GROUP BY order_id
)
SELECT order_id
FROM A
WHERE max_quantity > (SELECT MAX(avg_quantity) FROM A)