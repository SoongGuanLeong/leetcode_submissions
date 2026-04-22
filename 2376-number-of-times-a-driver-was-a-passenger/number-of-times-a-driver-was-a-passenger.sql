-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT DISTINCT driver_id FROM Rides
)
SELECT 
    A.driver_id AS driver_id,
    COUNT(passenger_id) AS cnt
FROM A LEFT JOIN Rides r
ON A.driver_id = r.passenger_id
GROUP BY 1