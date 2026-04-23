-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT 
        item_category,
        TO_CHAR(order_date, 'FMDay') AS day_of_week,
        SUM(quantity) AS quantity
    FROM Orders o
    FULL OUTER JOIN Items i
    ON o.item_id = i.item_id
    GROUP BY 1, 2
)
SELECT item_category AS "Category",
    SUM(CASE WHEN day_of_week='Monday' THEN quantity ELSE 0 END) AS "Monday",
    SUM(CASE WHEN day_of_week='Tuesday' THEN quantity ELSE 0 END) AS "Tuesday",
    SUM(CASE WHEN day_of_week='Wednesday' THEN quantity ELSE 0 END) AS "Wednesday",
    SUM(CASE WHEN day_of_week='Thursday' THEN quantity ELSE 0 END) AS "Thursday",
    SUM(CASE WHEN day_of_week='Friday' THEN quantity ELSE 0 END) AS "Friday",
    SUM(CASE WHEN day_of_week='Saturday' THEN quantity ELSE 0 END) AS "Saturday",
    SUM(CASE WHEN day_of_week='Sunday' THEN quantity ELSE 0 END) AS "Sunday"
FROM A
GROUP BY 1
ORDER BY 1