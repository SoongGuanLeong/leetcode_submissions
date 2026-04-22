/* Write your T-SQL query statement below */
WITH A AS (
    SELECT *,
        CASE WHEN start_day <= 
            MAX(end_day) 
            OVER(PARTITION BY hall_id ORDER BY start_day
                ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING
            ) THEN 1 ELSE 0
        END AS can_merge
    FROM HallEvents
), B AS (
    SELECT *,
        SUM(CASE WHEN can_merge = 0 THEN 1 ELSE 0 END) 
            OVER(ORDER BY hall_id, start_day 
                ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)         
        AS merge_id
    FROM A
)
SELECT hall_id,
    MIN(start_day) AS start_day,
    MAX(end_day) AS end_day
FROM B
GROUP BY hall_id, merge_id