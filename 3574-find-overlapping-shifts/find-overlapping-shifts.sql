WITH EmployeeShifts_modified AS (
    SELECT *, 
        ROW_NUMBER() OVER(ORDER BY employee_id, start_time, end_time) AS row_num
    FROM EmployeeShifts
)
SELECT
    e1.employee_id AS employee_id, 
    COUNT(1) AS overlapping_shifts
FROM EmployeeShifts_modified e1 JOIN EmployeeShifts_modified e2
ON e1.employee_id = e2.employee_id
WHERE e1.start_time < e2.start_time
AND e1.start_time < e2.end_time
AND e1.end_time > e2.start_time
AND e1.row_num <> e2.row_num
GROUP BY 1
ORDER BY 1
