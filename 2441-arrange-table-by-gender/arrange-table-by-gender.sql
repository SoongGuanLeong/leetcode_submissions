-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT *,
        CASE WHEN gender = 'female' THEN 1
            WHEN gender = 'other' THEN 2
            WHEN gender = 'male' THEN 3
        END AS gender_order,
        ROW_NUMBER() OVER(PARTITION BY gender ORDER BY user_id) AS row_num
    FROM Genders
)
SELECT user_id, gender FROM A
ORDER BY row_num, gender_order

