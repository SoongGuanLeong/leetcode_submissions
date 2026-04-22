-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT 
        user_id,
        i.category
    FROM ProductPurchases p
    JOIN ProductInfo i
    ON p.product_id = i.product_id
)
SELECT
    a1.category AS category1,
    a2.category AS category2,
    COUNT(DISTINCT a1.user_id) AS customer_count
FROM A a1
JOIN A a2
ON a1.user_id = a2.user_id
AND a1.category < a2.category
GROUP BY 1, 2
HAVING COUNT(DISTINCT a1.user_id) >= 3
ORDER BY 3 DESC, 1, 2