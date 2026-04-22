-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT DISTINCT post_id, extra
    FROM Actions
    WHERE action_date = DATE '2019-07-04'
    AND action = 'report'
)
SELECT extra AS report_reason, COUNT(1) AS report_count
FROM A
GROUP BY extra