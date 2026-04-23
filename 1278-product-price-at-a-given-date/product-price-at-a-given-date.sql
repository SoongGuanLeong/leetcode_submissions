# Write your MySQL query statement below
SELECT DISTINCT a.product_id, IF(target_date IS NULL, 10, new_price) AS price
FROM Products a
LEFT JOIN
    (SELECT product_id, MAX(change_date) AS target_date
    FROM Products
    WHERE change_date <= "2019-08-16"
    GROUP BY product_id) AS b
ON a.product_id = b.product_id
WHERE change_date = target_date OR target_date IS NULL
