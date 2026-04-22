-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT user_id, tweet_id, tweet_date, tweet, hashtag_array[1] AS hashtag
    FROM Tweets,
    LATERAL REGEXP_MATCHES(tweet, '#[A-Za-z]+', 'g') AS t1(hashtag_array)
)
SELECT hashtag, COUNT(1)
FROM A
GROUP BY 1
ORDER BY 2 DESC, 1 DESC
LIMIT 3