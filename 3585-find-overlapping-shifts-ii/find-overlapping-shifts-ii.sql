-- Write your PostgreSQL query statement below
WITH EmployeeShifts_modified AS (
    SELECT *, 
        ROW_NUMBER() OVER(ORDER BY employee_id, start_time, end_time) AS row_num
    FROM EmployeeShifts
), A AS (
    SELECT 
        e1.employee_id AS employee_id,
        e1.start_time AS t1_start_time,
        e1.end_time AS t1_end_time,
        e2.start_time AS t2_start_time,
        e2.end_time AS t2_end_time,
        e1.row_num AS t1_row_num,
        e2.row_num AS t2_row_num
    FROM EmployeeShifts_modified e1 JOIN EmployeeShifts_modified e2
    ON e1.employee_id = e2.employee_id
    WHERE e1.start_time < e2.start_time
    AND e1.start_time < e2.end_time
    AND e1.end_time > e2.start_time
    AND e1.row_num <> e2.row_num
), B AS (
    SELECT DISTINCT t1_row_num AS id, employee_id, t1_start_time AS time, 1 AS tag FROM A
    UNION
    SELECT DISTINCT t1_row_num, employee_id, t1_end_time, -1 FROM A
    UNION
    SELECT DISTINCT t2_row_num, employee_id, t2_start_time, 1 FROM A
    UNION
    SELECT DISTINCT t2_row_num, employee_id, t2_end_time, -1 FROM A
), C AS (
    SELECT *, 
        SUM(tag) OVER(PARTITION BY employee_id ORDER BY time
                        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
        AS active_cnt 
    FROM B
), D AS (
    SELECT employee_id,
        SUM(EXTRACT(EPOCH FROM (t1_end_time - t2_start_time)) / 60) 
        AS total_overlap_duration 
    FROM A
    GROUP BY 1
), E AS (
    SELECT employee_id, MAX(active_cnt) AS max_overlapping_shifts
    FROM C
    GROUP BY 1
)
SELECT 
    DISTINCT es.employee_id,
    COALESCE(max_overlapping_shifts, 1) AS max_overlapping_shifts,
    COALESCE(total_overlap_duration, 0) AS total_overlap_duration 
FROM EmployeeShifts es LEFT JOIN D
ON es.employee_id = D.employee_id
LEFT JOIN E
ON es.employee_id = E.employee_id
ORDER BY 1