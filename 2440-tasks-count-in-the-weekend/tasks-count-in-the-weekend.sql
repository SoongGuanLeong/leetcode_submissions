-- Write your PostgreSQL query statement below
SELECT 
    SUM(CASE WHEN EXTRACT(DOW FROM submit_date) = 6 
                    OR EXTRACT(DOW FROM submit_date) = 0
            THEN 1 ELSE 0 END) 
    AS weekend_cnt,
    SUM(CASE WHEN EXTRACT(DOW FROM submit_date) <> 6 
                    AND EXTRACT(DOW FROM submit_date) <> 0
            THEN 1 ELSE 0 END) 
    AS working_cnt
FROM Tasks

