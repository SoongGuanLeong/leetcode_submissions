-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT task_id, employee_id, start_time AS time, 1 AS flag FROM Tasks
    UNION ALL 
    SELECT task_id, employee_id, end_time, -1 FROM Tasks  
), B AS (
    SELECT employee_id, SUM(EXTRACT(EPOCH FROM (end_time - start_time)) / 60) AS fake_total_task_min
    FROM Tasks
    GROUP BY employee_id
), C AS (
    SELECT *, 
        SUM(flag) OVER(PARTITION BY employee_id ORDER BY time, task_id
                        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
        AS concurrent_tasks
    FROM A
), D AS (
    SELECT *,
        CASE WHEN LAG(concurrent_tasks) OVER(PARTITION BY employee_id ORDER BY time) >= 2
                AND  concurrent_tasks < LAG(concurrent_tasks) OVER(PARTITION BY employee_id ORDER BY time)
            THEN EXTRACT(EPOCH FROM(time - LAG(time) OVER(PARTITION BY employee_id ORDER BY time))) / 60
            ELSE 0
        END AS overlap_time_min
    FROM C
), E AS (
    SELECT employee_id, 
        MAX(concurrent_tasks) AS max_concurrent_tasks, 
        SUM(overlap_time_min) AS total_overlap_time_min 
    FROM D GROUP BY 1
)
SELECT B.employee_id AS employee_id,
    FLOOR((fake_total_task_min - total_overlap_time_min) / 60) AS total_task_hours,
    max_concurrent_tasks
FROM B LEFT JOIN E
ON B.employee_id = E.employee_id

