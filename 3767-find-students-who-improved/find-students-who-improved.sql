-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT *,
        ROW_NUMBER()OVER(PARTITION BY student_id, subject ORDER BY exam_date) AS row_num,
        DENSE_RANK()OVER(ORDER BY student_id, subject) AS id
    FROM Scores
), B AS (
    SELECT *,
        MIN(row_num)OVER(PARTITION BY id) AS min_row_num,
        MAX(row_num)OVER(PARTITION BY id) AS max_row_num
    FROM A
    WHERE id IN (SELECT id FROM A WHERE row_num > 1)
), C AS (
    SELECT id, student_id, subject, score AS first_score
    FROM B
    WHERE row_num = min_row_num
), D AS (
    SELECT id, student_id, subject, score AS latest_score
    FROM B
    WHERE row_num = max_row_num
)
SELECT C.student_id, C.subject, first_score, latest_score
FROM C JOIN D
ON C.id = D.id
WHERE first_score < latest_score 



