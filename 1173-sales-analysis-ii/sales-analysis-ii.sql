-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT DISTINCT buyer_id FROM Sales
    WHERE product_id IN (SELECT product_id FROM Product WHERE product_name = 'S8')
),
B AS (
    SELECT DISTINCT buyer_id FROM Sales
    WHERE product_id IN (SELECT product_id FROM Product WHERE product_name = 'iPhone')
)
SELECT * FROM A
WHERE buyer_id NOT IN (SELECT * FROM B)