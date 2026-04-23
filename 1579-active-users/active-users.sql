-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT COALESCE(L.id, a.id) AS id, name, login_date,
        CASE 
            WHEN LAG(login_date) 
                OVER(PARTITION BY COALESCE(L.id, a.id) ORDER BY login_date) IS NULL THEN 1
            WHEN login_date - INTERVAL '1 DAY' > LAG(login_date) 
                                                        OVER(PARTITION BY COALESCE(L.id, a.id) ORDER BY login_date)
                THEN 1 
            ELSE 0
        END AS is_new_streak
    FROM Logins L
    FULL OUTER JOIN Accounts a
    ON L.id = a.id
    ORDER BY 1, 2 ,3
), B AS (
    SELECT *,
        SUM(is_new_streak) 
            OVER(ORDER BY id, login_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
        AS streak_id
    FROM A
), C AS (
    SELECT streak_id, COUNT(DISTINCT login_date) AS consecutive_days
    FROM B
    GROUP BY 1
)
SELECT DISTINCT id, name
FROM B JOIN C
ON B.streak_id = C.streak_id
WHERE consecutive_days >= 5
ORDER BY 1

