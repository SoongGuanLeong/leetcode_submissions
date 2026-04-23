# Write your MySQL query statement below
SELECT seller_name
FROM Orders o
RIGHT JOIN Seller s
ON o.seller_id = s.seller_id
WHERE o.seller_id NOT IN 
    (
        SELECT DISTINCT seller_id FROM Orders
        WHERE YEAR(sale_date) = 2020 
    )
    OR o.seller_id IS NULL
ORDER BY seller_name
