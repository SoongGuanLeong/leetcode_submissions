-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT *,
        ROW_NUMBER() 
            OVER(PARTITION BY server_id, session_status ORDER BY status_time)
        AS session_id
    FROM Servers
), B AS (
    SELECT server_id, session_id,
        EXTRACT(EPOCH FROM (status_time 
                            - LAG(status_time) OVER(PARTITION BY server_id, session_id
                                                    ORDER BY status_time)
                            )
                ) / 3600
        AS duration_hours
    FROM A
)
SELECT FLOOR(SUM(duration_hours) / 24) AS total_uptime_days
FROM B