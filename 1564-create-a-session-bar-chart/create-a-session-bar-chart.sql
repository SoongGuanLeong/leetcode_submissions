-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT *,
        CASE 
            WHEN (duration / 60.0) >= 15 THEN '15 or more'
            WHEN (duration / 60.0) >= 10 THEN '[10-15>'
            WHEN (duration / 60.0) >= 5 THEN '[5-10>'
            WHEN (duration / 60.0) >= 0 THEN '[0-5>'   
        END AS bin
    FROM Sessions
), B AS (
    SELECT *
    FROM (VALUES
        ('[0-5>'), 
        ('[5-10>'),
        ('[10-15>'),
        ('15 or more')
    ) AS t(bin)
)
SELECT B.bin,
    COUNT(A.bin) AS total
FROM B LEFT JOIN A
ON B.bin = A.bin
GROUP BY 1
    