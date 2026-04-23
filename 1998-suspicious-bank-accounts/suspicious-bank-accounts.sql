-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT 
        account_id,
        DATE_TRUNC('month', day) AS year_month,
        SUM(amount) AS amount    
    FROM Transactions
    WHERE type = 'Creditor'
    GROUP BY 1, 2
), B AS (
    SELECT COALESCE(A.account_id, ac.account_id) AS account_id,
        year_month, amount, max_income,
        CASE WHEN amount > max_income 
                AND LEAD(amount) OVER(PARTITION BY COALESCE(A.account_id, ac.account_id) 
                        ORDER BY year_month DESC) 
                    > LEAD(max_income) OVER(PARTITION BY COALESCE(A.account_id, ac.account_id) 
                        ORDER BY year_month DESC)
                AND year_month - INTERVAL '1 MONTH' 
                    = LEAD(year_month) OVER(PARTITION BY COALESCE(A.account_id, ac.account_id)
                        ORDER BY year_month DESC)
            THEN 1
            ELSE 0
        END AS exceed_max_2_month
    FROM A LEFT JOIN Accounts ac
    ON A.account_id = ac.account_id
)
SELECT DISTINCT account_id FROM B
WHERE exceed_max_2_month = 1
