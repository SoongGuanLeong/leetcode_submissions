-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT customer_id, 
        EXTRACT(YEAR FROM order_date) AS order_year,
        SUM(price) AS total_purchases
    FROM Orders
    GROUP BY 1, 2
), B AS (
    SELECT *,
        CASE WHEN total_purchases > 
            COALESCE(LAG(total_purchases) OVER(PARTITION BY customer_id ORDER BY order_year), 0)
            AND order_year - 
                COALESCE(LAG(order_year) OVER(PARTITION BY customer_id ORDER BY order_year), order_year -1) = 1
        THEN 1 ELSE 0
        END AS fulfil_requirement
    FROM A
), C AS (
    SELECT customer_id, 
        MIN(fulfil_requirement) AS fulfil_requirement
    FROM B 
    GROUP BY 1
)
SELECT customer_id FROM C
WHERE fulfil_requirement = 1
