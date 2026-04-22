-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT pass_from, time_stamp, pass_to,
        t1.team_name AS team_name,
        CASE WHEN t1.team_name = t2.team_name THEN 1 ELSE 0 END AS successful_pass
    FROM Passes p LEFT JOIN Teams t1
    ON p.pass_from = t1.player_id
    LEFT JOIN Teams t2
    ON p.pass_to = t2.player_id
), B AS (
    SELECT time_stamp, team_name, successful_pass,
        CASE WHEN LAG(successful_pass) OVER(PARTITION BY team_name ORDER BY team_name, time_stamp) IS NULL THEN 1
            WHEN successful_pass != LAG(successful_pass) OVER(PARTITION BY team_name ORDER BY team_name, time_stamp) THEN 1
            ELSE 0
        END AS is_new_streak
    FROM A
), C AS (
    SELECT *,
        SUM(is_new_streak) 
            OVER(ORDER BY team_name, time_stamp 
                ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
        AS streak_id
    FROM B
), D AS (
    SELECT team_name, streak_id, COUNT(1) AS streak_len
    FROM C
    WHERE successful_pass = 1
    GROUP BY 1, 2
)
SELECT team_name, MAX(streak_len) AS longest_streak
FROM D
GROUP BY 1
ORDER BY 1