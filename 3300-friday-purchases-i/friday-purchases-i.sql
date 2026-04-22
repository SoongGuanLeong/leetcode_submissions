-- Write your PostgreSQL query statement below
SELECT 
    EXTRACT(WEEK FROM purchase_date)
    - EXTRACT(WEEK FROM DATE_TRUNC('MONTH', DATE '2023=11-01')) + 1
    AS week_of_month,
    purchase_date,
    SUM(amount_spend) AS total_amount
FROM Purchases
WHERE EXTRACT(YEAR FROM purchase_date) = 2023
AND EXTRACT(MONTH FROM purchase_date) = 11
AND EXTRACT(DOW FROM purchase_date) = 5
GROUP BY 1, 2