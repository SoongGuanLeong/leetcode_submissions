-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT *,
        AVG(occurrences) OVER(PARTITION BY event_type) AS avg_event_occurrences
    FROM Events
), B AS (
    SELECT *,
        CASE WHEN occurrences > avg_event_occurrences THEN 1 ELSE 0 END AS is_higher
    FROM A
)
SELECT business_id
FROM B
GROUP BY business_id
HAVING SUM(is_higher) > 1