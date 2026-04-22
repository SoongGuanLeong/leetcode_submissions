-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT *,
        likes::DECIMAL / (likes + dislikes) * 100 AS pct
    FROM Problems
)
SELECT problem_id
FROM A
WHERE pct < 60
ORDER BY 1