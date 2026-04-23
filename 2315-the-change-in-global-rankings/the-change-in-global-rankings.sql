-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT 
        COALESCE(p.team_id, c.team_id) AS team_id,
        name,
        points,
        points + points_change AS new_points,
        ROW_NUMBER() OVER(ORDER BY points DESC, name) AS old_rank,
        ROW_NUMBER() OVER(ORDER BY points + points_change DESC, name) AS new_rank,
        ROW_NUMBER() OVER(ORDER BY points DESC, name)
        - ROW_NUMBER() OVER(ORDER BY points + points_change DESC, name) AS rank_diff
    FROM TeamPoints p FULL OUTER JOIN PointsChange c
    ON p.team_id = c.team_id
)
SELECT team_id, name, rank_diff FROM A