-- Write your PostgreSQL query statement below
SELECT 
    p1.product_id AS product1_id,
    p2.product_id AS product2_id,
    i1.category AS product1_category,
    i2.category AS product2_category,
    COUNT(1) AS customer_count
FROM ProductPurchases p1
JOIN ProductPurchases p2
ON p1.user_id = p2.user_id
AND p1.product_id < p2.product_id
JOIN ProductInfo i1
ON i1.product_id = p1.product_id
JOIN ProductInfo i2
ON i2.product_id = p2.product_id
GROUP BY 1, 2, 3, 4
HAVING COUNT(1) >= 3
ORDER BY 5 DESC, 1, 2