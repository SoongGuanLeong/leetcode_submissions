-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT topic_id, LOWER(word) AS word, post_id, content
    FROM Keywords CROSS JOIN Posts
), B AS (
    SELECT *,
        CASE WHEN content ~* ('\m'||word||'\M') THEN topic_id END AS small_topic
    FROM A
), C AS (
    SELECT DISTINCT post_id, small_topic FROM B
)
SELECT post_id,
    COALESCE(
        STRING_AGG(small_topic::TEXT, ',' ORDER BY small_topic), 
        'Ambiguous!')
    AS topic
FROM C
GROUP BY 1
