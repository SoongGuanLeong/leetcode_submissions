-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT *
    FROM texts
    WHERE signup_action = 'Verified'
)
SELECT user_id
FROM A JOIN emails e
ON A.email_id = e.email_id
WHERE action_date::DATE = signup_date::DATE + INTERVAL '1 DAY'
ORDER BY 1