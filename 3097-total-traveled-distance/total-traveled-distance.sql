-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT user_id,
        SUM(distance) AS "traveled distance"
    FROM Rides
    GROUP BY 1
)
SELECT 
    u.user_id,
    name,
    COALESCE("traveled distance", 0) AS "traveled distance"
FROM Users u
LEFT JOIN A
ON u.user_id = A.user_id
ORDER BY 1
