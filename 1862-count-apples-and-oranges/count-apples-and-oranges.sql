-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT box_id,
        b.apple_count AS box_apple_count,
        b.orange_count AS box_orange_count,
        COALESCE(b.chest_id, c.chest_id) AS chest_id,
        c.apple_count  AS chest_apple_count,
        c.orange_count AS chest_orange_count
    FROM Boxes b
    LEFT JOIN Chests c
    ON b.chest_id = c.chest_id
)
SELECT 
    COALESCE(SUM(box_apple_count),0) + COALESCE(SUM(chest_apple_count),0) AS apple_count,
    COALESCE(SUM(box_orange_count),0) + COALESCE(SUM(chest_orange_count),0) AS orange_count
FROM A