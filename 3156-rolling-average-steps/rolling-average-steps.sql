-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT *,
        CASE WHEN LAG(steps_date) 
                    OVER(PARTITION BY user_id ORDER BY steps_date) IS NULL THEN 1
            WHEN steps_date 
                    - LAG(steps_date) OVER(PARTITION BY user_id ORDER BY steps_date) <> 1 THEN 1
            ELSE 0
        END AS is_new_streak
    FROM Steps
), B AS (
    SELECT *,
        SUM(is_new_streak) OVER(ORDER BY user_id, steps_date) AS streak_id
    FROM A
), C AS (
    SELECT streak_id, COUNT(*) AS streak_cnt
    FROM B
    GROUP BY streak_id
    HAVING COUNT(*) >= 3
), D AS (
    SELECT user_id, steps_date,
        ROUND(
            AVG(steps_count) OVER(PARTITION BY user_id ORDER BY steps_date
                                ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
            , 2)
        AS rolling_average,
        ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY steps_date) AS row_num
    FROM B
    WHERE streak_id IN (SELECT streak_id FROM C)
)
SELECT user_id, steps_date, rolling_average
FROM D
WHERE row_num >= 3
ORDER BY 1,2