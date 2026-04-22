-- Write your PostgreSQL query statement below
WITH RECURSIVE A AS (
    SELECT *, 
        0 AS hierarchy_level,
        salary AS root_salary
    FROM Employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT 
        e.employee_id,
        e.employee_name,
        e.manager_id,
        e.salary,
        A.hierarchy_level + 1 AS hierarchy_level,
        A.root_salary AS manager_salary
    FROM Employees e JOIN A
    ON e.manager_id = A.employee_id
)
SELECT
    employee_id AS subordinate_id,
    employee_name AS subordinate_name,
    hierarchy_level,
    salary - root_salary AS salary_difference
FROM A
WHERE manager_id IS NOT NULL
