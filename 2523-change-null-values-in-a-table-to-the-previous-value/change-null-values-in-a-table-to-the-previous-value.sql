-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT *,
        SUM(CASE WHEN drink IS NOT NULL THEN 1 ELSE 0 END)
            OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
        AS drink_id,
        ROW_NUMBER() OVER() AS row_num
    FROM CoffeeShop
), B AS (
    SELECT drink_id, drink FROM A WHERE drink IS NOT NULL
)
SELECT id, 
    COALESCE(A.drink, B.drink) AS drink
FROM A LEFT JOIN B
ON A.drink_id = B.drink_id
ORDER BY row_num

