-- Write your PostgreSQL query statement below
SELECT
    season_id,
    team_id,
    team_name,
    3 * wins + draws AS points,
    goals_for - goals_against AS goal_difference,
    ROW_NUMBER() 
        OVER(PARTITION BY season_id 
            ORDER BY 3 * wins + draws DESC, 
                goals_for - goals_against DESC,
                team_name DESC)
    AS position
FROM SeasonStats
