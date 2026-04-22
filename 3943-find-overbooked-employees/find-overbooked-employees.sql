-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT employee_id, 
        DATE_TRUNC('week', meeting_date) AS week_of_year,
        duration_hours
    FROM meetings
), B AS (
    SELECT employee_id, week_of_year, 
        CASE WHEN SUM(duration_hours) > 20 THEN 1 ELSE 0 END AS is_meeting_heavy
    FROM A
    GROUP BY employee_id, week_of_year
)
SELECT 
    B.employee_id,
    employee_name,
    department,
    SUM(is_meeting_heavy) AS meeting_heavy_weeks
FROM B
JOIN employees e
ON B.employee_id = e.employee_id
GROUP BY 1, 2, 3
HAVING SUM(is_meeting_heavy) >= 2
ORDER BY 4 DESC, 2