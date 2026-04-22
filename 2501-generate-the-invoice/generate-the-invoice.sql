-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT invoice_id,
        COALESCE(pr.product_id, pu.product_id) AS product_id,
        price, quantity,
        price * quantity AS total_price
    FROM Products pr RIGHT JOIN Purchases pu
    ON pr.product_id = pu.product_id
), B AS (
    SELECT invoice_id, SUM(total_price) AS total_revenue,
        RANK() OVER(ORDER BY SUM(total_price) DESC, invoice_id) AS rnk
    FROM A
    GROUP BY 1
)
SELECT product_id, quantity, total_price AS price
FROM A
WHERE invoice_id = (SELECT invoice_id FROM B WHERE rnk = 1)
