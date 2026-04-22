# Write your MySQL query statement below
SELECT 
    TRIM(LOWER(product_name)) AS product_name,
    DATE_FORMAT(sale_date, '%Y-%m') AS sale_date,
    COUNT(1) AS total
FROM Sales
GROUP BY 1, 2
ORDER BY 1, 2