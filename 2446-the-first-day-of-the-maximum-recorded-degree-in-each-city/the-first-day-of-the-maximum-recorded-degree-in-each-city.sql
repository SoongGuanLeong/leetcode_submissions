-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT *,
        ROW_NUMBER() OVER(PARTITION BY city_id ORDER BY degree DESC, day) AS row_num
    FROM Weather
)
SELECT city_id, day, degree
FROM A
WHERE row_num = 1