-- Write your PostgreSQL query statement below
WITH A AS (
        SELECT 
        t1.N AS N,
        t1.P AS parent,
        t2.N AS child
    FROM Tree t1
    LEFT JOIN Tree t2
    ON t1.N = t2.P
)
SELECT DISTINCT N,
    CASE WHEN parent IS NULL THEN 'Root'
        WHEN child IS NULL THEN 'Leaf'
        ELSE 'Inner'
    END AS Type
FROM A
ORDER BY N
