-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT first_name, type,
        TO_CHAR((duration || ' seconds')::interval, 'HH24:MI:SS') AS duration_formatted,
        ROW_NUMBER() OVER(PARTITION BY type ORDER BY duration DESC) AS row_num
    FROM Calls ca LEFT JOIN Contacts co
    ON ca.contact_id = co.id
)
SELECT first_name, type, duration_formatted
FROM A
WHERE row_num <= 3
ORDER BY 2 DESC, 3 DESC, 1 DESC