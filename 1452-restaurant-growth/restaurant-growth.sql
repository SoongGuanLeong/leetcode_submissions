# Write your MySQL query statement below
SELECT visited_on, amount, ROUND(amount/7,2) AS average_amount
FROM
    (SELECT visited_on,
        SUM(amount) OVER (ORDER BY visited_on RANGE BETWEEN INTERVAL 6 DAY PRECEDING AND CURRENT ROW) AS amount
    FROM (SELECT 
            visited_on, SUM(amount) AS amount FROM Customer
            GROUP BY visited_on) AS a) AS b
WHERE visited_on >= (SELECT DATE_ADD(MIN(visited_on), INTERVAL 6 DAY) FROM Customer)
GROUP BY visited_on