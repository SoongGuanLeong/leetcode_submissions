-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT 
        order_id, order_date,
        o.item_id AS item_id, item_brand,
        o.seller_id AS seller_id, join_date, favorite_brand
    FROM Orders o
    LEFT JOIN Users u
    ON o.seller_id = u.seller_id
    LEFT JOIN Items i
    ON o.item_id = i.item_id
), B AS (
    SELECT DISTINCT seller_id, item_id,
        CASE WHEN item_brand <> favorite_brand THEN 1 
        ELSE 0 END AS num_items
    FROM A
), C AS (
    SELECT seller_id, SUM(num_items) AS num_items FROM B
    GROUP BY 1
    ORDER BY 1
)
SELECT * FROM C
WHERE num_items = (SELECT MAX(num_items) FROM C)
ORDER BY 1
