-- Write your PostgreSQL query statement below
SELECT 
    EXTRACT(WEEK FROM t1.purchase_date)
    - EXTRACT(WEEK FROM DATE_TRUNC('MONTH', DATE '2023=11-01')) + 1
    AS week_of_month,
    DATE(t1.purchase_date) AS purchase_date,
    COALESCE(SUM(amount_spend), 0) AS total_amount
FROM Purchases p
RIGHT JOIN GENERATE_SERIES(
                    DATE '2023-11-01',
                    DATE '2023-11-30', 
                    INTERVAL '1 DAY') t1(purchase_date)
ON p.purchase_date = t1.purchase_date
WHERE EXTRACT(YEAR FROM t1.purchase_date) = 2023
AND EXTRACT(MONTH FROM t1.purchase_date) = 11
AND EXTRACT(DOW FROM t1.purchase_date) = 5
GROUP BY 1, 2