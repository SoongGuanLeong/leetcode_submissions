-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT AVG(price) AS national_avg FROM Listings
)
SELECT city
FROM Listings
GROUP BY 1
HAVING AVG(price) > (SELECT * FROM A)
ORDER BY 1