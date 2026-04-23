-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT *,
        ROW_NUMBER() OVER(PARTITION BY company ORDER BY salary, id) AS row_num,
        (COUNT(1) OVER(PARTITION BY company) + 1) / 2.0 AS median_loc
    FROM Employee
)
SELECT id, company, salary
FROM A
WHERE row_num = FLOOR(median_loc)
OR row_num = CEIL(median_loc)



