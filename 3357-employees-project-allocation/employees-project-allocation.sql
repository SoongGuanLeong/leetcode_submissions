-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT project_id, 
        p.employee_id AS employee_id,
        name, team,
        workload
    FROM Project p LEFT JOIN Employees e
    ON p.employee_id = e.employee_id
), B AS (
    SELECT team, AVG(workload) AS avg_workload 
    FROM A
    GROUP BY team
)
SELECT 
    employee_id AS EMPLOYEE_ID,
    project_id AS PROJECT_ID,
    name AS EMPLOYEE_NAME,
    workload AS PROJECT_WORKLOAD
FROM A LEFT JOIN B
ON A.team = B.team
WHERE workload > avg_workload
ORDER BY 1,2