-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT company_id, max(salary) AS max_salary
    FROM Salaries
    GROUP BY 1
)
SELECT 
    COALESCE(s.company_id, A.company_id) AS company_id,
    employee_id, employee_name,
    CAST(CASE WHEN max_salary < 1000 THEN salary
        WHEN max_salary BETWEEN 1000 AND 10000 THEN salary * (1-0.24)
        WHEN max_salary > 10000 THEN salary * (1-0.49)
    END AS INT) AS salary
FROM Salaries s
FULL OUTER JOIN A
ON s.company_id = A.company_id