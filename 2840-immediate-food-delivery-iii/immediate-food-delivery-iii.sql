-- Write your PostgreSQL query statement below
SELECT order_date,
    ROUND(
        SUM(CASE WHEN customer_pref_delivery_date = order_date THEN 1.0 ELSE 0.0 END)
        / 
        COUNT(order_date) * 100, 2)
    AS immediate_percentage 
FROM Delivery
GROUP BY order_date
ORDER BY order_date
