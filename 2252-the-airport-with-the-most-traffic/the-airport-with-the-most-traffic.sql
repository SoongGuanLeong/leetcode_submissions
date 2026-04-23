-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT departure_airport AS airport_id, flights_count FROM Flights 
    UNION ALL
    SELECT arrival_airport, flights_count FROM Flights 
), B AS (
    SELECT airport_id, SUM(flights_count) AS total_flights_count
    FROM A
    GROUP BY airport_id
)
SELECT airport_id
FROM B
WHERE total_flights_count = (SELECT MAX(total_flights_count) FROM B)