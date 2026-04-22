-- Write your PostgreSQL query statement below
WITH combined AS (
    SELECT COALESCE(d.driver_id, v.driver_id) AS driver_id,
        name, age, experience, accidents,
        COALESCE(v.vehicle_id, t.vehicle_id) AS vehicle_id,
        model, fuel_type, mileage,
        trip_id, distance, duration, rating,
        ROUND(AVG(rating) OVER(PARTITION BY fuel_type, COALESCE(d.driver_id, v.driver_id)), 2)
        AS avg_rating,
        SUM(distance) OVER(PARTITION BY fuel_type, COALESCE(d.driver_id, v.driver_id))
        AS total_distance
    FROM Drivers d JOIN Vehicles v
    ON d.driver_id = v.driver_id
    JOIN Trips t
    ON v.vehicle_id = t.vehicle_id
), A AS (
    SELECT *,
        ROW_NUMBER() 
            OVER(PARTITION BY fuel_type 
                    ORDER BY avg_rating DESC, total_distance DESC, accidents) AS row_num
    FROM combined
)
SELECT fuel_type, driver_id, avg_rating AS rating, total_distance AS distance
FROM A
WHERE row_num = 1



