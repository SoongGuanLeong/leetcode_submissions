-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT 
        pass_from,
        CASE WHEN (SUBSTR(time_stamp, 1, 2)::INTEGER / 60 || ':'
                    || SUBSTR(time_stamp, 1, 2)::INTEGER % 60 || ':'
                    || SUBSTR(time_stamp, 4, 2))::TIME > TIME '00:45:00' 
            THEN 2 ELSE 1 END AS half_number,
        pass_to,
        t1.team_name AS from_team_name,
        t2.team_name AS to_team_name,
        CASE WHEN t1.team_name = t2.team_name THEN 1 ELSE -1 END AS score
    FROM Passes p LEFT JOIN Teams t1
    ON p.pass_from = t1.player_id
    LEFT JOIN Teams t2
    ON p.pass_to = t2.player_id
)
SELECT from_team_name AS team_name,
    half_number,
    SUM(score) AS dominance
FROM A
GROUP BY 1, 2
ORDER BY 1, 2
