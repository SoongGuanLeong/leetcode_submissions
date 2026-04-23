-- Write your PostgreSQL query statement below\
WITH A AS (
    SELECT *,
        LAG(event_date) OVER(PARTITION BY player_id ORDER BY event_date) AS prev_date,
        LEAD(event_date) OVER(PARTITION BY player_id ORDER BY event_date) AS next_date
    FROM Activity
), B AS (
    SELECT *,
        CASE WHEN prev_date IS NULL THEN 1 ELSE 0 END AS install
    FROM A
), C AS (
    SELECT *,
        CASE WHEN install=1 THEN event_date END AS install_dt,
        CASE WHEN event_date + INTERVAL '1 DAY' = next_date THEN 1 ELSE 0 END AS day_1_retented
    FROM B
    ORDER BY event_date
)
SELECT install_dt, 
    SUM(install) AS installs, 
    ROUND(CAST(SUM(day_1_retented) AS NUMERIC) / CAST(SUM(install) AS NUMERIC), 2) AS "Day1_retention"
FROM C
WHERE install_dt IS NOT NULL
GROUP BY install_dt