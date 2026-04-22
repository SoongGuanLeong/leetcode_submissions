-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT product_id, EXTRACT(YEAR FROM purchase_date) AS year, COUNT(*) AS order_cnt
    FROM Orders
    GROUP BY 1, 2
), B AS (
    SELECT *,
        CASE WHEN year - LAG(year) OVER(PARTITION BY product_id ORDER BY year) = 1 THEN 1 ELSE 0
        END AS is_second_year
    FROM A
    WHERE order_cnt >= 3
)
SELECT DISTINCT product_id
FROM B 
WHERE is_second_year = 1
