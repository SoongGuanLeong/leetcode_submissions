-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT *,
        PERCENT_RANK() OVER(PARTITION BY state ORDER BY fraud_score DESC) AS pct_rnk
    FROM Fraud
)
SELECT policy_id, state, fraud_score
FROM A
WHERE pct_rnk <= 0.05
ORDER BY 2, 3 DESC, 1