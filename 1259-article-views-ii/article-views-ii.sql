-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT viewer_id, view_date, COUNT(DISTINCT article_id) AS article_number
    FROM Views
    GROUP BY viewer_id, view_date
)
SELECT DISTINCT viewer_id AS id
FROM A
WHERE article_number > 1
ORDER BY 1