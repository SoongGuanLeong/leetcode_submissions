-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT p1.x AS x1, 
        p1.y AS y1,
        p2.x AS x2, 
        p2.y AS y2
    FROM Point2D p1 JOIN Point2D p2
    ON (p1.x,p1.y) > (p2.x,p2.y)
), B AS (
    SELECT *, POWER(POWER((x1-x2),2) + POWER((y1-y2),2), 0.5) AS distance
    FROM A
)
SELECT ROUND(CAST(MIN(distance) AS NUMERIC), 2) AS shortest FROM B