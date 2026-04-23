WITH A AS (
    SELECT
        ROW_NUMBER() OVER(ORDER BY user_id, spend_date, platform) AS row_num,
        user_id, spend_date, 
        'both' AS platform,
        CASE WHEN platform != LAG(platform) OVER(PARTITION BY user_id, spend_date) THEN amount
            WHEN platform != LEAD(platform) OVER(PARTITION BY user_id, spend_date) THEN amount
            ELSE 0
        END AS amount
    FROM Spending
), B AS (
    SELECT ROW_NUMBER() OVER(ORDER BY user_id, spend_date, platform) AS row_num,
    * FROM Spending
), C AS (
    SELECT
        COALESCE(B.user_id, A.user_id) AS user_id,
        COALESCE(B.spend_date, A.spend_date) AS spend_date,
        CASE WHEN A.amount = 0 THEN B.platform ELSE A.platform END AS platform,
        CASE WHEN A.amount = 0 THEN B.amount ELSE A.amount END AS amount
    FROM B FULL OUTER JOIN A
    ON B.row_num = A.row_num
), D AS (
    SELECT *
    FROM (SELECT DISTINCT spend_date FROM C)t1 
    CROSS JOIN 
    (SELECT DISTINCT platform FROM C UNION SELECT 'both' AS platform)t2
), E AS (
    SELECT spend_date, platform, SUM(amount) AS total_amount,
        COUNT(DISTINCT user_id) AS total_users
    FROM C
    GROUP BY 1, 2
)
SELECT 
    COALESCE(D.spend_date, E.spend_date) AS spend_date,
    COALESCE(D.platform, E.platform) AS platform,
    COALESCE(total_amount, 0) AS total_amount,
    COALESCE(total_users, 0) AS total_users
FROM D FULL OUTER JOIN E
ON D.spend_date = E.spend_date
AND D.platform = E.platform
ORDER BY 1, 2

