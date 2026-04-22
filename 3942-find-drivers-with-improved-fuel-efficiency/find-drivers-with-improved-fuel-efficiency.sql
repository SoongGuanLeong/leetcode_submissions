-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT
        driver_id,
        distance_km,
        fuel_consumed,
        CASE 
            WHEN EXTRACT (MONTH FROM trip_date) BETWEEN 1 AND 6 THEN 'first_half'
            WHEN EXTRACT (MONTH FROM trip_date) BETWEEN 7 AND 12 THEN 'second_half'
        END AS tag
    FROM trips
), B AS (
    SELECT driver_id,
        AVG(CASE WHEN tag = 'first_half' THEN distance_km::DECIMAL / fuel_consumed END) AS first_half_avg,
        AVG(CASE WHEN tag = 'second_half' THEN distance_km::DECIMAL / fuel_consumed END) AS second_half_avg
    FROM A
    GROUP BY driver_id
)
SELECT
    B.driver_id,
    driver_name,
    ROUND(first_half_avg, 2) AS first_half_avg,
    ROUND(second_half_avg, 2) AS second_half_avg,
    ROUND(second_half_avg - first_half_avg, 2) AS efficiency_improvement
FROM B
JOIN drivers d
ON B.driver_id = d.driver_id
WHERE first_half_avg IS NOT NULL 
AND second_half_avg IS NOT NULL
AND second_half_avg > first_half_avg
ORDER BY 5 DESC, 2