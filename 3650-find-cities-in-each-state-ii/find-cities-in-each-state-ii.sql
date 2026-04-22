-- Write your PostgreSQL query statement below
SELECT state, 
    STRING_AGG(city, ', ' ORDER BY city) AS cities,
    SUM(CASE WHEN LEFT(state, 1) = LEFT(city, 1) 
            THEN 1 ELSE 0 END) 
    AS matching_letter_count
FROM cities
GROUP BY state
HAVING SUM(CASE WHEN LEFT(state, 1) = LEFT(city, 1) 
            THEN 1 ELSE 0 END) > 0
AND COUNT(DISTINCT city) >= 3
ORDER BY SUM(CASE WHEN LEFT(state, 1) = LEFT(city, 1) 
            THEN 1 ELSE 0 END) DESC, state