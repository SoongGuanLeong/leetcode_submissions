-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT
        tweet_id,
        unnest(string_to_array(content, ' ')) AS word
    FROM Tweets
), B AS (
    SELECT tweet_id, 
        SUM(CASE WHEN word ~ '#[A-Za-z0-9_]+' THEN 1 ELSE 0 END) AS h_cnt,
        SUM(CASE WHEN word ~ '@[A-Za-z0-9_]+' THEN 1 ELSE 0 END) AS m_cnt
    FROM A
    GROUP BY tweet_id
)
SELECT t.tweet_id
FROM Tweets t JOIN B
ON t.tweet_id = B.tweet_id
WHERE LENGTH(content) > 140
OR h_cnt > 3
OR m_cnt > 3
