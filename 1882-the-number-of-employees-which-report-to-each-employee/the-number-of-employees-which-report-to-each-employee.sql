# Write your MySQL query statement below
SELECT b.employee_id, b.name, COUNT(a.employee_id) AS reports_count, ROUND(AVG(a.age)) AS average_age
FROM Employees a
JOIN Employees b
ON a.reports_to = b.employee_id
GROUP BY employee_id
ORDER BY employee_id
