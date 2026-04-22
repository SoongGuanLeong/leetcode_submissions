-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT DISTINCT user_id
    FROM Loans
    WHERE loan_type = 'Refinance'
), B AS (
    SELECT DISTINCT user_id
    FROM Loans
    WHERE loan_type = 'Mortgage'
)
SELECT A.user_id
FROM A JOIN B
ON A.user_id = B.user_id