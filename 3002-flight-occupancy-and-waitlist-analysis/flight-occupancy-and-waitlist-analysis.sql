-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT flight_id, COUNT(*) AS cnt
    FROM Passengers
    GROUP BY flight_id
)
SELECT
    f.flight_id AS flight_id,
    LEAST(COALESCE(cnt, 0), capacity) AS booked_cnt,
    GREATEST(COALESCE(cnt, 0) - capacity, 0) AS waitlist_cnt
FROM A RIGHT JOIN Flights f
ON A.flight_id = f.flight_id
ORDER BY 1
