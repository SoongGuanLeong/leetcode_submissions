-- Write your PostgreSQL query statement below
WITH RECURSIVE A AS (
    SELECT
        employee_id,
        employee_name,
        manager_id,
        salary,
        1 AS level,
        ARRAY[employee_id] AS path
    FROM Employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT
        e.employee_id,
        e.employee_name,
        e.manager_id,
        e.salary,
        A.level + 1,
        A.path || e.employee_id
    FROM Employees e
    JOIN A 
    ON e.manager_id = A.employee_id
)
SELECT
    p.employee_id,
    p.employee_name,
    p.level,
    COUNT(1) - 1 AS team_size,
    SUM(c.salary) AS budget
FROM A p
JOIN A c
ON c.path @> ARRAY[p.employee_id]
GROUP BY 1,2,3
ORDER BY 3, 5 DESC, 2