-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT *,
        CASE WHEN people >= 100 THEN 1 ELSE 0 
        END AS more_than_100,
        COALESCE(LAG(id) OVER(ORDER BY id), 0) AS previous_row_id,
        id - 1 AS supposed_id
    FROM Stadium
), B AS (
    SELECT *,
        CASE WHEN more_than_100=1 AND previous_row_id=supposed_id THEN 1 ELSE 0 
        END AS pass_check
    FROM A
), C AS (
    SELECT *, 
        CASE WHEN LAG(pass_check) OVER(ORDER BY id) IS NULL THEN 1
            WHEN LAG(pass_check) OVER(ORDER BY id) != pass_check THEN 1
            ELSE 0
        END AS new_streak
    FROM B
), D AS (
    SELECT *,
        SUM(new_streak) OVER(ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS streak_id
    FROM C
), E AS (
    SELECT *, SUM(pass_check) OVER(PARTITION BY streak_id ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS consecutive_count
    FROM D
)
SELECT id, visit_date, people FROM E
WHERE consecutive_count >= 3
ORDER BY id
