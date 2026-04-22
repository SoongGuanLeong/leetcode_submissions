-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT team_name,
        3 * wins + draws AS points,
        RANK() OVER(ORDER BY 3 * wins + draws DESC) AS position
    FROM TeamStats
)
SELECT *,
    CASE WHEN position <= CEIL(0.33 * (SELECT COUNT(*) FROM TeamStats))
            THEN 'Tier 1'
        WHEN position <= CEIL(0.66 * (SELECT COUNT(*) FROM TeamStats))
            THEN 'Tier 2'
        ELSE 'Tier 3'
    END AS tier
FROM A
ORDER BY 2 DESC, 1