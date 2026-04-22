-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT
        *,
        ROW_NUMBER()OVER(PARTITION BY employee_id ORDER BY review_date DESC) AS row_num
    FROM performance_reviews
), B AS (
    SELECT *,
        CASE 
            WHEN LAG(rating)OVER(PARTITION BY employee_id ORDER BY row_num) IS NULL THEN 1
            WHEN LAG(rating)OVER(PARTITION BY employee_id ORDER BY row_num) > rating THEN 1
            ELSE 0
        END AS flag
    FROM A
    WHERE employee_id IN (SELECT employee_id FROM A WHERE row_num = 3)
    AND row_num < 4
), C AS (
    SELECT
        employee_id,
        MAX(rating) - MIN(rating) AS improvement_score
    FROM B 
    WHERE employee_id IN (SELECT employee_id FROM B GROUP BY employee_id HAVING SUM(flag) = 3)
    GROUP BY employee_id
)
SELECT C.employee_id, name, improvement_score 
FROM C
JOIN employees e
ON C.employee_id = e.employee_id
ORDER BY 3 DESC, name

