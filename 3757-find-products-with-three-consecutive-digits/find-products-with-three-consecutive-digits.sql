-- Write your PostgreSQL query statement below
SELECT *
FROM Products
WHERE name ~ '(^|[^0-9])[0-9]{3}([^0-9]|$)'