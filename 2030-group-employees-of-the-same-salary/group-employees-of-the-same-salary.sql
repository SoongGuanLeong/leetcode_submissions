-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT salary, COUNT(salary) AS salary_cnt
    FROM Employees
    GROUP BY salary
    HAVING COUNT(salary) >= 2
)
SELECT employee_id, name,
    A.salary AS salary,
    DENSE_RANK() OVER(ORDER BY A.salary) AS team_id
FROM A
LEFT JOIN Employees e
ON A.salary = e.salary
ORDER BY 4, 1