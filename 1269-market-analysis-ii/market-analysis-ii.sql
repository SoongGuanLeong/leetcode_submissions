-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT 
        order_date,
        COALESCE(o.item_id, i.item_id) AS item_id,
        COALESCE(user_id, seller_id) AS seller_id,
        favorite_brand,
        item_brand
    FROM Users u FULL OUTER JOIN Orders o
    ON user_id = seller_id
    FULL OUTER JOIN Items i
    ON o.item_id = i.item_id
), B AS (
    SELECT *, ROW_NUMBER() OVER(PARTITION BY seller_id ORDER BY order_date) AS row_num
    FROM A
)
SELECT seller_id,
    CASE 
        WHEN SUM(CASE WHEN favorite_brand=item_brand AND row_num=2 THEN 1 ELSE 0 END) = 1 THEN 'yes' ELSE 'no'
    END AS "2nd_item_fav_brand"
FROM B
WHERE seller_id IS NOT NULL
GROUP BY 1
ORDER BY 1