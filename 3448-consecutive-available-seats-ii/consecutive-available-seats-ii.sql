-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT *,
        CASE WHEN LAG(free) OVER(ORDER BY seat_id) IS NULL THEN 1
            WHEN free <> LAG(free) OVER(ORDER BY seat_id) THEN 1
        ELSE 0
        END AS is_new_streak
    FROM Cinema
), B AS (
    SELECT *,
        SUM(is_new_streak) OVER(ORDER BY seat_id) AS streak_id
    FROM A
), C AS (
    SELECT streak_id,
        MIN(seat_id) AS first_seat_id,
        MAX(seat_id) AS last_seat_id,
        COUNT(1) AS consecutive_seats_len
    FROM B
    WHERE free = 1 
    GROUP BY 1
)
SELECT first_seat_id, last_seat_id, consecutive_seats_len
FROM C
WHERE consecutive_seats_len = (SELECT MAX(consecutive_seats_len) FROM C)
ORDER BY 1

