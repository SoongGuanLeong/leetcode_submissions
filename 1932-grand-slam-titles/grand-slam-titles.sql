# Write your MySQL query statement below
SELECT player_id, player_name, COUNT(player_id) AS grand_slams_count
FROM Players JOIN
(SELECT Wimbledon FROM Championships UNION ALL
    SELECT Fr_open FROM Championships UNION ALL
    SELECT US_open FROM Championships UNION ALL
    SELECT Au_open FROM Championships) AS t1
ON player_id = Wimbledon
GROUP BY player_id