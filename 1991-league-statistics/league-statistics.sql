-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT *,
        CASE WHEN home_team_goals > away_team_goals THEN 3
            WHEN home_team_goals = away_team_goals THEN 1
            ELSE 0
        END AS home_pts,
        CASE WHEN away_team_goals > home_team_goals THEN 3
            WHEN away_team_goals = home_team_goals THEN 1
            ELSE 0
        END AS away_pts
    FROM MATCHES
), B AS (
    SELECT home_team_id AS team_id,
        COUNT(home_team_id) AS matches_played,
        SUM(home_pts) AS points,
        SUM(home_team_goals) AS goal_for,
        SUM(away_team_goals) AS goal_against
    FROM A
    GROUP BY home_team_id
    UNION ALL
    SELECT away_team_id,
        COUNT(away_team_id) AS away_played,
        SUM(away_pts) AS away_pts,
        SUM(away_team_goals) AS home_goal_for,
        SUM(home_team_goals) AS home_goal_against
    FROM A
    GROUP BY away_team_id
)
SELECT team_name,
    SUM(matches_played) AS matches_played,
    SUM(points) AS points,
    SUM(goal_for) AS goal_for,
    SUM(goal_against) AS goal_against,
    SUM(goal_for) - SUM(goal_against) AS goal_diff
FROM B LEFT JOIN Teams t
ON B.team_id = t.team_id
GROUP BY 1
ORDER BY 3 DESC, 6 DESC, 1
