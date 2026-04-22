-- Write your PostgreSQL query statement below
SELECT artist,
    COUNT(1) AS occurrences
FROM Spotify
GROUP BY 1
ORDER BY 2 DESC, 1
