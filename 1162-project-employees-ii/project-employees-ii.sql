# Write your MySQL query statement below
WITH A AS (
    SELECT 
        project_id,
        COUNT(1) AS no_of_emp
    FROM Project
    GROUP BY project_id
)
SELECT project_id
FROM A
WHERE no_of_emp = (SELECT MAX(no_of_emp) AS max_emp FROM A)