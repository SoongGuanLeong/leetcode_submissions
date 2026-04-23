-- Write your PostgreSQL query statement below
WITH A AS (
SELECT id,
    COALESCE(s.employee_id, e.employee_id) AS employee_id,
    department_id, amount, pay_date,
    TO_CHAR(pay_date, 'YYYY-MM') AS pay_month
FROM Salary s
FULL OUTER JOIN Employee e
ON s.employee_id = e.employee_id
), B AS (
    SELECT *,
        AVG(amount) OVER(PARTITION BY pay_month) AS avg_company_salary,
        AVG(amount) OVER(PARTITION BY pay_month, department_id) AS avg_dept_salary
    FROM A
)
SELECT DISTINCT pay_month, department_id, 
    CASE WHEN avg_dept_salary > avg_company_salary THEN 'higher'
        WHEN avg_dept_salary = avg_company_salary THEN 'same'
        ELSE 'lower'
    END AS comparison
FROM B

