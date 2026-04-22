-- Write your PostgreSQL query statement below
SELECT 
    sp.salesperson_id AS salesperson_id,
    name,
    COALESCE(SUM(price), 0) AS total
FROM Sales s LEFT JOIN Customer c
ON s.customer_id = c.customer_id
RIGHT JOIN Salesperson sp
ON c.salesperson_id = sp.salesperson_id
GROUP BY 1, 2