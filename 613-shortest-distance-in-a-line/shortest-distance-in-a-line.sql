# Write your MySQL query statement below
SELECT MIN(ABS(x1 - x2)) AS shortest
FROM
    (SELECT p1.x AS x1, p2.x AS x2 FROM Point p1
    JOIN Point p2
    WHERE p1.x != p2.x) AS t1