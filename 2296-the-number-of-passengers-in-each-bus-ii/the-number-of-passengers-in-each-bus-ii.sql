-- Write your PostgreSQL query statement below
WITH RECURSIVE A AS (
    SELECT bus_id, b.arrival_time AS bus_arrival_time, capacity,
        passenger_id, p.arrival_time AS passenger_arrival_time,
        DENSE_RANK() OVER(ORDER BY b.arrival_time, bus_id) AS bus_row_num
    FROM Buses b
    CROSS JOIN Passengers p
), B AS (
    SELECT bus_row_num, bus_id, bus_arrival_time, capacity,
        SUM(CASE WHEN bus_arrival_time >= passenger_arrival_time THEN 1 ELSE 0 END) AS passengers_cnt 
    FROM A
    GROUP BY bus_row_num, bus_id, bus_arrival_time, capacity
), C AS (
    SELECT bus_row_num, bus_id, capacity,
        passengers_cnt - COALESCE(LAG(passengers_cnt) OVER(ORDER BY bus_arrival_time), 0) AS passengers_cnt 
    FROM B
), D AS (
    SELECT *,
        GREATEST(passengers_cnt - capacity, 0) AS leftover
    FROM C
    WHERE bus_row_num = (SELECT MIN(bus_row_num) FROM C)
    UNION ALL
    SELECT C.bus_row_num, C.bus_id, C.capacity,
        C.passengers_cnt + D.leftover AS passengers_cnt,
        GREATEST(C.passengers_cnt + D.leftover - C.capacity, 0)
    FROM C JOIN D
    ON C.bus_row_num = D.bus_row_num + 1
)
SELECT bus_id, passengers_cnt - leftover  AS passengers_cnt
FROM D
ORDER BY 1