-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT *,
        purchase_date 
        - LAG(purchase_date) OVER(PARTITION BY user_id ORDER BY purchase_date)
        AS days_since_last_purchase
    FROM Purchases
)
SELECT DISTINCT user_id
FROM A
WHERE days_since_last_purchase <= 7
