-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT bus_id, b.arrival_time AS bus_arrival_time,
        passenger_id, p.arrival_time AS passenger_arrival_time
    FROM Buses b
    CROSS JOIN Passengers p
), B AS (
    SELECT bus_id, bus_arrival_time,
        SUM(CASE WHEN bus_arrival_time >= passenger_arrival_time THEN 1 ELSE 0 END) AS passengers_cnt 
    FROM A
    GROUP BY bus_id, bus_arrival_time
)
SELECT bus_id,
    passengers_cnt - COALESCE(LAG(passengers_cnt) OVER(ORDER BY bus_arrival_time), 0) AS passengers_cnt 
FROM B
ORDER BY bus_id