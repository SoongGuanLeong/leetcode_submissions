-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT product_id, 
        EXTRACT(YEAR FROM transaction_date) AS year,
        SUM(spend) AS curr_year_spend
    FROM user_transactions
    GROUP BY 1, 2
), B AS (
    SELECT *,
        CASE WHEN year - 1 = LAG(year) OVER(PARTITION BY product_id ORDER BY year)
            THEN LAG(curr_year_spend) OVER(PARTITION BY product_id ORDER BY year)
            ELSE NULL
        END AS prev_year_spend
    FROM A
)
SELECT year, product_id, curr_year_spend, prev_year_spend,
    ROUND((curr_year_spend - prev_year_spend) 
        / NULLIF(prev_year_spend, 0) * 100.0 , 2)
    AS yoy_rate 
FROM B
