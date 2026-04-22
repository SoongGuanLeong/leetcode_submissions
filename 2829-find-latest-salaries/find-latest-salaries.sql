-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT emp_id, MAX(salary) AS salary
    FROM Salary
    GROUP BY 1
)
SELECT 
    A.emp_id,
    firstname,
    lastname,
    A.salary,
    department_id
FROM A JOIN Salary s
ON A.emp_id = s.emp_id 
AND A.salary = s.salary
ORDER BY 1