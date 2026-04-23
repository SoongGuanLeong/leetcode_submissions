-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT *,
        SUM(salary) OVER(PARTITION BY experience ORDER BY salary 
                            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cum_salary,
        ROW_NUMBER() OVER(PARTITION BY experience ORDER BY salary) AS row_num
    FROM Candidates
), B AS (
    SELECT 
        COALESCE(MAX(experience), 'Senior') AS experience,
        COALESCE(MAX(cum_salary), 0) AS cum_salary, 
        COALESCE(MAX(row_num), 0) AS accepted_candidates
    FROM A
    WHERE experience = 'Senior'
    AND cum_salary <= 70000
), C AS (
    SELECT 
        COALESCE(MAX(experience), 'Junior') AS experience, 
        COALESCE(MAX(cum_salary), 0) AS cum_salary, 
        COALESCE(MAX(row_num), 0) AS accepted_candidates
    FROM A
    WHERE experience = 'Junior'
    AND cum_salary <= 70000 - (SELECT cum_salary FROM B)
), D AS (
    SELECT experience, accepted_candidates FROM B
    UNION ALL
    SELECT experience, accepted_candidates FROM C
)
SELECT employee_id 
FROM D JOIN A
ON D.experience = A.experience
WHERE row_num <= accepted_candidates