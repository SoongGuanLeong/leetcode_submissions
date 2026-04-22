/* Write your T-SQL query statement below */
WITH A AS (
    SELECT *, (minute +5) / 6 AS interval_no
    FROM Orders
)
SELECT interval_no, SUM(order_count) AS total_orders
FROM A
GROUP BY interval_no