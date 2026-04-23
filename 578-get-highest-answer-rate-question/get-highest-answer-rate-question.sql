-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT question_id, 
        CAST(SUM(CASE WHEN action='show' THEN 1 ELSE 0 END) AS NUMERIC) 
        AS show_count, 
        CAST(SUM(CASE WHEN answer_id IS NOT NULL THEN 1 ELSE 0 END) AS NUMERIC)  
        AS answered_count
    FROM SurveyLog
    GROUP BY question_id
), B AS (
    SELECT *, answered_count/show_count AS answer_rate
    FROM A
)
SELECT question_id AS survey_log
FROM B
ORDER BY answer_rate DESC, question_id
LIMIT 1