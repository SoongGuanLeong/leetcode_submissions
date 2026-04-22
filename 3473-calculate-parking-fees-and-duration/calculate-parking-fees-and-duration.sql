-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT *,
        EXTRACT(EPOCH FROM(exit_time - entry_time)) / 3600 AS hour_spent
    FROM ParkingTransactions
), B AS (
    SELECT car_id, 
        ROUND(SUM(fee_paid), 2) AS total_fee_paid,
        ROUND(SUM(fee_paid) / SUM(hour_spent), 2) AS avg_hourly_fee
    FROM A
    GROUP BY car_id
), C AS (
    SELECT car_id, lot_id, SUM(hour_spent) AS hour_spent,
        ROW_NUMBER() OVER(PARTITION BY car_id ORDER BY SUM(hour_spent) DESC) AS row_num
    FROM A
    GROUP BY 1, 2
)
SELECT C.car_id AS car_id,
    total_fee_paid, avg_hourly_fee, 
    lot_id AS most_time_lot
FROM C JOIN B
ON C.car_id = B.car_id
WHERE row_num = 1
ORDER BY 1