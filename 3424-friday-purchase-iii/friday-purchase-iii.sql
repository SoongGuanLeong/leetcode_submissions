-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT p.user_id AS user_id,
        membership, purchase_date, amount_spend,
        EXTRACT(WEEK FROM purchase_date) 
            - EXTRACT(WEEK FROM DATE '2023-11-01') + 1 AS week_of_month
    FROM Purchases p LEFT JOIN Users u
    ON p.user_id = u.user_id
    WHERE EXTRACT(YEAR FROM purchase_date) = 2023
    AND EXTRACT(MONTH FROM purchase_date) = 11
    AND EXTRACT(DOW FROM purchase_date) = 5
    AND membership IN ('Premium', 'VIP')
), B AS (
    SELECT week_of_month, membership, SUM(amount_spend) AS total_amount
    FROM A
    GROUP BY 1,2
), C AS (
    SELECT * FROM
    (SELECT GENERATE_SERIES(1,4) AS week_of_month)t1
    CROSS JOIN
    (SELECT DISTINCT membership FROM Users 
        WHERE membership IN ('Premium', 'VIP'))t2
)
SELECT C.week_of_month AS week_of_month,
    C.membership AS membership,
    COALESCE(total_amount, 0) AS total_amount 
FROM C FULL OUTER JOIN B
ON C.week_of_month = B.week_of_month
AND C.membership = B.membership
ORDER BY 1, 2