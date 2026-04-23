-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT DISTINCT post_id, action_date FROM Actions
    WHERE extra = 'spam'
), B AS (
    SELECT
        COALESCE(A.post_id, r.post_id) AS post_id,
        action_date,
        remove_date
    FROM A LEFT JOIN Removals r
    ON A.post_id = r.post_id
), C AS (
    SELECT action_date,
        CAST(SUM(CASE WHEN remove_date IS NOT NULL THEN 1 ELSE 0 END) AS NUMERIC) 
        / 
        COUNT(1) * 100 AS daily_percent
    FROM B
    GROUP BY 1
)
SELECT ROUND(AVG(daily_percent), 2) AS average_daily_percent FROM C