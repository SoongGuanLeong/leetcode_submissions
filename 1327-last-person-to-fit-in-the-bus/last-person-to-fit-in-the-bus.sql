# Write your MySQL query statement below
SELECT person_name
FROM
    (SELECT turn, person_name, weight, SUM(weight) OVER (ORDER BY turn) AS cumulative
    FROM Queue) AS a
WHERE cumulative <= 1000
ORDER BY cumulative DESC
LIMIT 1