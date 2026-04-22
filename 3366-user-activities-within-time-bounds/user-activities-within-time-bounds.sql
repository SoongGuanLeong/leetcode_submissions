-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT *,
        CASE WHEN EXTRACT(EPOCH FROM session_start - 
                                    LAG(session_end)  
                                        OVER(PARTITION BY user_id, session_type ORDER BY session_start)) / 3600 <= 12
            AND session_type = LAG(session_type) OVER(PARTITION BY user_id, session_type ORDER BY session_start)
        THEN 1 ELSE 0
        END AS pass_check
    FROM Sessions
    ORDER BY user_id, session_start
)
SELECT DISTINCT user_id FROM A
WHERE pass_check = 1
