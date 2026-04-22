-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT *, 
        ROW_NUMBER() 
            OVER(PARTITION BY user_id ORDER BY transaction_date) 
        AS row_num,
        LAG(spend) OVER(PARTITION BY user_id ORDER BY transaction_date) AS previous_spend,
        LAG(spend, 2) OVER(PARTITION BY user_id ORDER BY transaction_date) AS previous2_spend
    FROM Transactions
)
SELECT user_id, 
    spend AS third_transaction_spend, 
    transaction_date AS third_transaction_date
FROM A
WHERE row_num = 3
AND spend > previous_spend
AND spend > previous2_spend 