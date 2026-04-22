-- Write your PostgreSQL query statement below
SELECT 
    person_id,
    name || '(' || SUBSTRING(profession, 1, 1) || ')'
    AS name
FROM Person
ORDER BY 1 DESC