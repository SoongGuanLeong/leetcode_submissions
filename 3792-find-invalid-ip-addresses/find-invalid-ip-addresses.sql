-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT *
    FROM logs
    WHERE ip !~* $$(?x)
        ^
        (25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\.
        (25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\.
        (25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])\.
        (25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])
        $
        $$
)
SELECT ip,
    COUNT(1) AS invalid_count
FROM A
GROUP BY ip
ORDER BY 2 DESC, 1 DESC