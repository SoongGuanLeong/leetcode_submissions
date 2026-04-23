-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT e1.id AS id, e1.name AS name, e1.salary AS salary,
        COALESCE(e1.managerId, e2.Id) AS managerId,
        e2.name AS manager_name,
        e2.salary AS manager_salary
    FROM Employee e1 
    FULL OUTER JOIN Employee e2
    ON e1.managerId = e2.Id
    WHERE e1.id IS NOT NULL
)
SELECT name AS employee
FROM A
WHERE salary > manager_salary
