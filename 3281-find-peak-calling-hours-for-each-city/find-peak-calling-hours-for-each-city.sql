-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT city, EXTRACT(HOUR FROM call_time) AS call_hour,
        COUNT(*) AS number_of_calls 
    FROM Calls
    GROUP BY 1, 2
), B AS (
    SELECT city, MAX(number_of_calls) AS number_of_calls FROM A GROUP BY city
)
SELECT B.city AS city,
    call_hour AS peak_calling_hour,
    B.number_of_calls AS number_of_calls
FROM B LEFT JOIN A
ON B.city = A.city
AND B.number_of_calls = A.number_of_calls
ORDER BY 2 DESC, 1 DESC
