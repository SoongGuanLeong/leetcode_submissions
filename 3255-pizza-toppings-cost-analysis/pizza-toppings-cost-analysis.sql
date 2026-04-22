-- Write your PostgreSQL query statement below
SELECT
    t1.topping_name||','||t2.topping_name||','||t3.topping_name AS pizza,
    t1.cost + t2.cost + t3.cost AS total_cost
FROM Toppings t1 CROSS JOIN Toppings t2 CROSS JOIN Toppings t3
WHERE t1.topping_name < t2.topping_name
AND t1.topping_name < t3.topping_name
AND t2.topping_name < t3.topping_name
ORDER BY 2 DESC, 1