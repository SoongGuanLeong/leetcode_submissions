-- Write your PostgreSQL query statement below
SELECT COALESCE(u.user_id, buyer_id) AS buyer_id,
    join_date,
    SUM(CASE WHEN DATE_PART('YEAR', order_date)=2019 THEN 1 ELSE 0 END) AS orders_in_2019
FROM Users u FULL OUTER JOIN Orders o
ON u.user_id = buyer_id
GROUP BY 1, 2