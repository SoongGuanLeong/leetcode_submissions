-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT *,
        MAX(height) OVER(ORDER BY id) AS right_boundary,
        MAX(height) OVER(ORDER BY id DESC) AS left_boundary, 
        LEAST(MAX(height) OVER(ORDER BY id), 
            MAX(height) OVER(ORDER BY id DESC)) 
            - height AS trapped_water
    FROM Heights
)
SELECT SUM(trapped_water) AS total_trapped_water
FROM A