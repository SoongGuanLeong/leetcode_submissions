-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT first_col,
        ROW_NUMBER() OVER(ORDER BY first_col) AS row_num
    FROM Data
), B AS (
    SELECT second_col,
        ROW_NUMBER() OVER(ORDER BY second_col DESC) AS row_num
    FROM Data
)
SELECT first_col, second_col
FROM A JOIN B
ON A.row_num = B.row_num


