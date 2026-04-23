-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT gold_medal AS user_id, 
        COUNT(gold_medal)
    FROM Contests
    GROUP BY 1
    HAVING COUNT(gold_medal) >= 3
), B AS (
    SELECT contest_id, gold_medal AS user_id FROM Contests
    UNION ALL
    SELECT contest_id, silver_medal AS user_id FROM Contests
    UNION ALL
    SELECT contest_id, bronze_medal AS user_id FROM Contests
), C AS (
    SELECT user_id, contest_id, 
        CASE WHEN SUM(contest_id) OVER(PARTITION BY user_id ORDER BY contest_id
                                ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) 
                    = contest_id * 3 + 3
                THEN 1
            ELSE 0
        END AS is_3_streak
    FROM B
    ORDER BY user_id, contest_id
), D AS (
    SELECT user_id, SUM(is_3_streak) AS is_3_streak_cnt
    FROM C 
    GROUP BY user_id
    HAVING SUM(is_3_streak) >= 1
)
SELECT name, mail
FROM A FULL OUTER JOIN D
ON A.user_id = D.user_id
LEFT JOIN Users u
ON COALESCE(A.user_id, D.user_id) = u.user_id