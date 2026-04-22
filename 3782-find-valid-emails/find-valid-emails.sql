-- Write your PostgreSQL query statement below
SELECT *
FROM Users
WHERE email ~ '^[A-Za-z0-9]+@[a-z]+\.com$'
ORDER BY 1