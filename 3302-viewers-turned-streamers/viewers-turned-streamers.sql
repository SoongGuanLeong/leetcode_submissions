-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT *,
        ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY session_start) AS row_num
    FROM Sessions
), B AS (
    SELECT user_id FROM A
    WHERE row_num = 1
    AND session_type = 'Viewer'
)
SELECT B.user_id AS user_id,
    SUM(CASE WHEN session_type = 'Streamer' THEN 1 ELSE 0 END) AS sessions_count
FROM B 
LEFT JOIN A
ON B.user_id = A.user_id
GROUP BY 1
HAVING SUM(CASE WHEN session_type = 'Streamer' THEN 1 ELSE 0 END) > 0
ORDER BY 2 DESC, 1 DESC