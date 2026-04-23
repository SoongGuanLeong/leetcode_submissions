-- Write your PostgreSQL query statement below
SELECT 
    a.id AS p1,
    b.id AS p2,
    ABS((a.x_value - b.x_value) * (a.y_value - b.y_value)) AS area
FROM Points a CROSS JOIN Points b
WHERE a.id < b.id
AND ABS((a.x_value - b.x_value) * (a.y_value - b.y_value)) > 0
ORDER BY 3 DESC, 1, 2