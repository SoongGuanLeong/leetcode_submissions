-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT *,
        COUNT(post_id) OVER(PARTITION BY user_id ORDER BY post_date
                            RANGE BETWEEN INTERVAL '6 DAY' PRECEDING AND CURRENT ROW)
        AS seven_day_posts
    FROM Posts
    WHERE EXTRACT(YEAR FROM post_date) = 2024
    AND EXTRACT(MONTH FROM post_date) = 2
    AND EXTRACT(DAY FROM post_date) <= 28
)
SELECT user_id,
    MAX(seven_day_posts) AS max_7day_posts,
    ROUND(COUNT(post_id) * 1.0 / 4, 2) AS avg_weekly_posts
FROM A
GROUP BY 1
HAVING MAX(seven_day_posts) >= ROUND(COUNT(post_id) * 1.0 / 4, 2) * 2
ORDER BY 1