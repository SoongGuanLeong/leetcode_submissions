# Write your MySQL query statement below
WITH t1 AS (
    SELECT employee_id FROM Employees
    WHERE manager_id = 1
    UNION
    SELECT employee_id FROM Employees
    WHERE manager_id IN 
    (SELECT employee_id FROM Employees
    WHERE manager_id = 1)
    UNION
    SELECT employee_id FROM Employees
    WHERE manager_id IN
    (SELECT employee_id FROM Employees
    WHERE manager_id IN 
    (SELECT employee_id FROM Employees
    WHERE manager_id = 1))
)

SELECT employee_id FROM t1
WHERE employee_id <> 1

