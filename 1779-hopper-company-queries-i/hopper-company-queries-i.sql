-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT *,
        DATE_TRUNC('month', join_date) AS year_month
    FROM Drivers
), B AS (
    SELECT year_month, 
        SUM(COUNT(DISTINCT driver_id)) OVER(ORDER BY year_month
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) 
        AS active_drivers
    FROM A
    GROUP BY 1
), C AS (
    SELECT EXTRACT(MONTH FROM year_month) AS month, active_drivers
    FROM B
    WHERE EXTRACT(YEAR FROM year_month) = 2020
), D AS (
    SELECT ride_id, DATE_TRUNC('MONTH', requested_at) AS year_month
    FROM Rides
    WHERE ride_id IN (SELECT ride_id FROM AcceptedRides)
), E AS (
    SELECT EXTRACT(MONTH FROM year_month) AS month, 
        COUNT(DISTINCT ride_id) AS accepted_rides
    FROM D
    WHERE EXTRACT(YEAR FROM year_month) = 2020
    GROUP BY 1
), F AS (
    SELECT GENERATE_SERIES(1,12) AS month
)
SELECT COALESCE(F.month, C.month, E.month) AS month,
    COALESCE(active_drivers, 
        MAX(active_drivers) 
            OVER(ORDER BY COALESCE(F.month, C.month, E.month) 
                ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),
        0) 
    AS active_drivers,
    COALESCE(accepted_rides, 0) AS accepted_rides
FROM F
FULL OUTER JOIN C ON F.month = C.month
FULL OUTER JOIN E ON F.month = E.month
ORDER BY 1