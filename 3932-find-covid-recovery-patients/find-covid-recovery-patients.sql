-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT *
    FROM covid_tests 
    WHERE result = 'Positive'
)
SELECT
    A.patient_id,
    patient_name,
    age,
    MIN(t.test_date) - MIN(A.test_date) AS recovery_time
FROM A
JOIN covid_tests t
ON A.patient_id = t.patient_id 
AND A.test_date < t.test_date
JOIN patients p
ON A.patient_id = p.patient_id
WHERE t.result = 'Negative'
GROUP BY 1, 2, 3
ORDER BY 4, 2