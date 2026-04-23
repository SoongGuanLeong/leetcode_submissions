-- Write your PostgreSQL query statement below
WITH client AS (
    SELECT * FROM users
    WHERE role = 'client'
), driver AS (
    SELECT * FROM users
    WHERE role = 'driver'
), A AS (
    SELECT id, 
        COALESCE(t.client_id, c.users_id) AS client_id,
        c.banned AS client_banned,
        COALESCE(t.driver_id, c.users_id) AS driver_id,
        d.banned AS driver_banned,
        city_id,
        status,
        request_at
    FROM trips t
    FULL OUTER JOIN client c
    ON t.client_id = c.users_id
    FULL OUTER JOIN driver d
    ON t.driver_id = d.users_id
), B AS (
    SELECT CAST(request_at AS DATE) AS day,
        SUM(CASE WHEN client_banned = 'No' AND driver_banned = 'No' THEN 1 ELSE 0 END) AS valid_records,
        SUM(CASE WHEN client_banned = 'No' AND driver_banned = 'No' AND status != 'completed' THEN 1 ELSE 0 END) AS cancelled_trips
    FROM A
    GROUP BY request_at
)
SELECT day AS "Day", 
    ROUND(CAST(cancelled_trips AS NUMERIC) / CAST(valid_records AS NUMERIC), 2) AS "Cancellation Rate"
FROM B
WHERE day BETWEEN DATE '2013-10-01' AND DATE '2013-10-03'
AND valid_records >= 1


