# Write your MySQL query statement below
SELECT name
FROM SalesPerson s
WHERE s.sales_id NOT IN (
    SELECT o.sales_id FROM Orders o, Company c
    WHERE o.com_id = c.com_id
    AND c.name = "RED"
)