-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT product_id FROM Sales
    WHERE sale_date < DATE '2019-01-01' 
    OR sale_date > DATE '2019-03-31'
),
B AS (
    SELECT product_id FROM Sales
    WHERE sale_date BETWEEN DATE '2019-01-01' AND DATE '2019-03-31'
)
SELECT product_id, product_name
FROM Product
WHERE product_id NOT IN (SELECT * FROM A)
AND product_id IN (SELECT * FROM B)