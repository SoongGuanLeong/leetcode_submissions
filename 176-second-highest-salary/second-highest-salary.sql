/* Write your PL/SQL query statement below */
WITH A AS (
    SELECT 
        Employee.*, DENSE_RANK() OVER(ORDER BY salary DESC) AS drank
    FROM Employee;
)
SELECT MAX(salary) AS SecondHighestSalary
FROM A
WHERE drank = 2