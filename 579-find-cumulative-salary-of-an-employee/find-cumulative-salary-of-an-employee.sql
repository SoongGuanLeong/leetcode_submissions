-- Write your PostgreSQL query statement below
WITH A AS (
SELECT GENERATE_SERIES(1,12) AS month
), B AS (
    SELECT id, month 
    FROM A CROSS JOIN
    (SELECT DISTINCT(id) FROM Employee)t
    ORDER BY id, month
), C AS (
    SELECT 
        COALESCE(e.id, B.id) AS id,
        COALESCE(e.month, B.month) AS month,
        salary
    FROM Employee e FULL OUTER JOIN B
    ON e.id = B.id 
    AND e.month = B.month
    ORDER BY 1,2
), D AS (
    SELECT id, month,
        SUM(salary) 
            OVER(PARTITION BY id ORDER BY id, month DESC
                ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) AS salary
    FROM C
), E AS (
    SELECT *, 
        ROW_NUMBER() OVER(PARTITION BY id ORDER BY id, month DESC) AS row_num
    FROM D 
    WHERE (id, month) IN (SELECT id, month FROM Employee)
)
SELECT id, month, salary AS "Salary" FROM E 
WHERE row_num != 1
ORDER BY 1, 2 DESC

