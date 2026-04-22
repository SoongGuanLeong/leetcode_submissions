-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT MAX(salary) AS eng_salary
    FROM Salaries
    WHERE department = 'Engineering'
), B AS (
    SELECT MAX(salary) AS ma_salary
    FROM Salaries
    WHERE department = 'Marketing'
)
SELECT ABS(eng_salary - ma_salary) AS salary_difference
FROM A, B