-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT team_id, team_name, 
        3 * wins + draws AS points
    FROM TeamStats
)
SELECT *,
    RANK()OVER(ORDER BY points DESC) AS position
FROM A
ORDER BY 3 DESC, 2