-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT DISTINCT X AS x, Y AS y FROM Coordinates WHERE X < Y
    UNION ALL
    SELECT DISTINCT Y, X FROM Coordinates WHERE X > Y
    UNION ALL
    SELECT * FROM Coordinates WHERE X = Y
), B AS (
    SELECT x, y, COUNT(*) AS cnt
    FROM A
    GROUP BY 1, 2
    HAVING COUNT(*) >= 2
)
SELECT x, y FROM B
ORDER BY x, y
