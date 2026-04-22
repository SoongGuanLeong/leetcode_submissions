-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT *,
        COUNT(1) 
            OVER(PARTITION BY customer_id, category) AS category_count
    FROM Transactions t LEFT JOIN Products p
    ON t.product_id = p.product_id
), B AS (
    SELECT *,
    ROW_NUMBER() 
            OVER(PARTITION BY customer_id 
                ORDER BY category_count DESC, transaction_date DESC) 
        AS row_num
    FROM A
)
SELECT customer_id,
    SUM(amount) AS total_amount,
    COUNT(1) AS transaction_count,
    COUNT(DISTINCT category) AS unique_categories,
    ROUND(AVG(amount), 2) AS avg_transaction_amount,
    MAX(CASE WHEN row_num = 1 THEN category END) AS top_category,
    ROUND(10 * COUNT(1) + SUM(amount) / 100, 2) AS loyalty_score
FROM B
GROUP BY 1
ORDER BY 7 DESC, 1
