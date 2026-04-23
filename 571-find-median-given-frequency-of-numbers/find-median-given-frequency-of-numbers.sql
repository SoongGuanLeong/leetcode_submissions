-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT *,
        SUM(frequency) 
            OVER(ORDER BY num ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cum_freq,
        (SUM(frequency) OVER () + 1) / 2.0 AS median_loc
    FROM Numbers
)
SELECT AVG(num) AS median
FROM A 
WHERE FLOOR(median_loc) <= cum_freq
AND CEIL(median_loc) >= cum_freq - frequency + 1