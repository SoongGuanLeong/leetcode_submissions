-- Write your PostgreSQL query statement below
SELECT
    SUBSTRING(tweet FROM '#[A-Za-z]+') AS hashtag, COUNT(*) AS hashtag_count
FROM Tweets
GROUP BY 1
ORDER BY 2 DESC, 1 DESC
LIMIT 3
