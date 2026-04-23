-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT *,
        ROW_NUMBER() OVER(PARTITION BY username ORDER BY startDate DESC) AS row_num
    FROM UserActivity
), B AS (
    SELECT username, MAX(row_num) AS row_num FROM A
    WHERE row_num <= 2
    GROUP BY 1
)
SELECT COALESCE(B.username, A.username) AS username,
    activity,
    startDate, endDate
FROM B JOIN A
ON B.username = A.username
AND B.row_num = A.row_num


