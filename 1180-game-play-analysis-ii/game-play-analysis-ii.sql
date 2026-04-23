# Write your MySQL query statement below
SELECT player_id, device_id FROM
    (SELECT player_id, device_id, ROW_NUMBER()OVER(PARTITION BY player_id ORDER BY event_date) AS rnk
    FROM Activity) AS t1
WHERE rnk = 1