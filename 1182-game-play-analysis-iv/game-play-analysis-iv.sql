# Write your MySQL query statement below
SELECT ROUND(SUM(DATEDIFF(event_date, first_date) = 1)/COUNT(DISTINCT player_id),2) AS fraction
FROM
    (SELECT a.player_id, a.event_date, b.first_date
    FROM Activity a
    JOIN 
        (SELECT player_id, MIN(event_date) AS first_date
        FROM Activity
        GROUP BY player_id) AS b
    ON a.player_id = b.player_id) as c