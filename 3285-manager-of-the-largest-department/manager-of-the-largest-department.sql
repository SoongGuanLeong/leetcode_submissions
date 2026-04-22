-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT dep_id, COUNT(*) AS dep_size
    FROM Employees
    GROUP BY 1
), B AS (
    SELECT * FROM A
    WHERE dep_size = (SELECT MAX(dep_size) FROM A)
)
SELECT emp_name AS manager_name,
    B.dep_id AS dep_id
FROM B LEFT JOIN Employees e
ON B.dep_id = e.dep_id
WHERE position = 'Manager'
ORDER BY 2
