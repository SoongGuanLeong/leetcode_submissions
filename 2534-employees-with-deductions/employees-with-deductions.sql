-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT employee_id, 
        SUM(ROUND(EXTRACT(EPOCH FROM (out_time - in_time)) / 3600., 2)) AS total_hours
    FROM Logs
    GROUP BY employee_id
)
SELECT 
    e.employee_id AS employee_id
FROM A RIGHT JOIN Employees e
ON A.employee_id = e.employee_id
WHERE COALESCE(total_hours, 0) < needed_hours 
