-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT
        CASE 
            WHEN TO_CHAR(sale_date, 'FMMonth') IN ('December', 'January', 'February') THEN 'Winter'
            WHEN TO_CHAR(sale_date, 'FMMonth') IN ('March', 'April', 'May') THEN 'Spring'
            WHEN TO_CHAR(sale_date, 'FMMonth') IN ('June', 'July', 'August') THEN 'Summer'
            WHEN TO_CHAR(sale_date, 'FMMonth') IN ('September', 'October', 'November') THEN 'Fall'
        END AS season,
        category,
        SUM(quantity) AS total_quantity,
        SUM(quantity * price) AS total_revenue
    FROM sales s
    JOIN products p
    ON s.product_id = p.product_id
    GROUP BY 1, 2
), B AS (
    SELECT *, RANK()OVER(PARTITION BY season ORDER BY total_quantity DESC, total_revenue DESC, category) AS rnk FROM A
)
SELECT season, category, total_quantity, total_revenue FROM B
WHERE rnk = 1
ORDER BY 1
