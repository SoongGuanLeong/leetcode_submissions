-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT
        f.id AS id,
        f.name AS name,
        COALESCE(f.activity, a.name) AS activity
    FROM Friends f
    RIGHT JOIN Activities a
    ON f.activity = a.name
), B AS (
    SELECT activity, COUNT(1) AS activity_count
    FROM A
    GROUP BY 1
), C AS (
    SELECT MIN(activity_count) AS min_count, MAX(activity_count) AS max_count FROM B
)
SELECT activity FROM B CROSS JOIN C
WHERE activity_count > min_count
AND activity_count < max_count