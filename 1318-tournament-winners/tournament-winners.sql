-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT first_player AS player_id,
        first_score AS score
    FROM Matches
    UNION ALL
    SELECT second_player AS player_id,
        second_score AS score
    FROM Matches
), B AS (
    SELECT player_id, SUM(score) AS score
    FROM A
    GROUP BY 1
), C AS (
    SELECT COALESCE(p.player_id, B.player_id) AS player_id,
        group_id,
        COALESCE(score, CAST(0 AS INTEGER)) AS score,
        ROW_NUMBER() 
            OVER(PARTITION BY group_id 
                 ORDER BY COALESCE(score, CAST(0 AS INTEGER)) DESC, 
                        COALESCE(p.player_id, B.player_id))        
        AS row_num
    FROM Players p FULL OUTER JOIN B
    ON p.player_id = B.player_id
)
SELECT group_id, player_id
FROM C
WHERE row_num=1