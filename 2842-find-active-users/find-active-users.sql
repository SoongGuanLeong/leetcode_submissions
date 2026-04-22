-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT user_id, 
        CASE WHEN created_at 
                    - 
                    LAG(created_at) OVER(PARTITION BY user_id ORDER BY created_at) <= 7
            THEN 1
        END AS is_active
    FROM Users
)
SELECT DISTINCT user_id 
FROM A
WHERE is_active = 1