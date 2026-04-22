-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT DISTINCT parent_id, sub_id
    FROM Submissions
    WHERE parent_id IS NOT NULL
), B AS (
    SELECT parent_id AS post_id,
        COUNT(1) AS number_of_comments
    FROM A
    GROUP BY parent_id
), C AS (
    SELECT DISTINCT sub_id AS post_id
    FROM Submissions
    WHERE parent_id IS NULL
)
SELECT 
    C.post_id,
    COALESCE(number_of_comments, 0) AS number_of_comments
FROM C LEFT JOIN B
ON C.post_id = B.post_id
ORDER BY 1
