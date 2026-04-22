-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT *,
        CASE WHEN LAG(transaction_date) OVER(PARTITION BY customer_id ORDER BY transaction_date) IS NULL THEN 1
            WHEN (transaction_date -
            LAG(transaction_date) OVER(PARTITION BY customer_id ORDER BY transaction_date) <> 1 
            OR amount <= LAG(amount) OVER(PARTITION BY customer_id ORDER BY transaction_date))
                THEN 1
            ELSE 0
        END AS is_new_streak
    FROM Transactions
), B AS (
    SELECT *,
        SUM(is_new_streak) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS streak_id
    FROM A
)
SELECT MIN(customer_id) AS customer_id,
    MIN(transaction_date) AS consecutive_start, 
    MAX(transaction_date) AS consecutive_end
FROM B
GROUP BY streak_id
HAVING COUNT(streak_id) >= 3
ORDER BY 1,2,3
