-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT account_id, day, 
        CASE WHEN type = 'Deposit' THEN amount
            WHEN type = 'Withdraw' THEN - amount
        END AS amount
    FROM Transactions
)
SELECT account_id, day,
    SUM(amount) OVER(PARTITION BY account_id ORDER BY day 
                        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
    AS balance
FROM A