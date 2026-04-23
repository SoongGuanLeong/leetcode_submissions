# Write your MySQL query statement below
SELECT team_id, team_name, SUM(
    CASE 
        WHEN host_goals > guest_goals AND team_id = host_team THEN 3
        WHEN host_goals < guest_goals AND team_id = guest_team THEN 3
        WHEN host_goals = guest_goals AND team_id = host_team THEN 1
        WHEN host_goals = guest_goals AND team_id = guest_team THEN 1
        ELSE 0
    END
) AS num_points
FROM Teams t 
LEFT JOIN Matches m
ON team_id = host_team OR team_id = guest_team
GROUP BY team_id
ORDER BY num_points DESC, team_id