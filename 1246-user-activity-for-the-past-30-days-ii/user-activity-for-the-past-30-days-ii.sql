-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT
        user_id, COUNT(DISTINCT session_id) AS session_cnt
    FROM Activity
    WHERE activity_date BETWEEN DATE '2019-07-27' - INTERVAL '29 DAY' AND DATE '2019-07-27'
    GROUP BY user_id
)
SELECT COALESCE(ROUND(AVG(session_cnt), 2), 0) AS average_sessions_per_user
FROM A
