-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT *,
        CASE WHEN time_stamp 
                    - LAG(time_stamp)OVER(PARTITION BY user_id ORDER BY time_stamp) <= INTERVAL '1 DAY' 
        THEN 1 ELSE 0 END AS condition
    FROM Confirmations
)
SELECT DISTINCT user_id 
FROM A
WHERE condition = 1