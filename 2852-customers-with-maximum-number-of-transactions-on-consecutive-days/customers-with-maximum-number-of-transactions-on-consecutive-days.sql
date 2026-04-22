-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT *,
        CASE WHEN LAG(transaction_date) OVER(PARTITION BY customer_id ORDER BY transaction_date) IS NULL THEN 1
            WHEN transaction_date -
            LAG(transaction_date) OVER(PARTITION BY customer_id ORDER BY transaction_date) <> 1 
                THEN 1
            ELSE 0
        END AS is_new_streak
    FROM Transactions
), B AS (
    SELECT *,
        SUM(is_new_streak) OVER(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS streak_id
    FROM A
), C AS (
    SELECT customer_id, streak_id, COUNT(streak_id) AS streak_cnt
    FROM B
    GROUP BY 1, 2
    order by 1,2 
)
SELECT customer_id FROM C
WHERE streak_cnt IN (SELECT MAX(streak_cnt) FROM C)
ORDER BY 1