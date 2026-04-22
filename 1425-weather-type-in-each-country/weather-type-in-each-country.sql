-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT country_id,
        AVG(weather_state) AS avg_weather_state
    FROM Weather
    WHERE day BETWEEN DATE '2019-11-01' AND DATE '2019-11-30'
    GROUP BY country_id
)
SELECT country_name,
    CASE WHEN avg_weather_state <= 15 THEN 'Cold'
        WHEN avg_weather_state >= 25 THEN 'Hot'
        ELSE 'Warm'
        END AS weather_type
FROM A JOIN Countries c
ON A.country_id = c.country_id