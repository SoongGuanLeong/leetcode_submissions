WITH A AS (
    SELECT product_id, 
        GENERATE_SERIES(period_start, period_end, INTERVAL '1 DAY') AS sales_date,
        average_daily_sales
    FROM Sales
)
SELECT COALESCE(A.product_id, p.product_id) AS product_id,
    product_name,
    CAST(DATE_PART('YEAR', sales_date) AS VARCHAR) AS report_year,
    SUM(average_daily_sales) AS total_amount
FROM A JOIN Product p
ON A.product_id = p.product_id
GROUP BY 1, 2, 3
ORDER BY 1, 3