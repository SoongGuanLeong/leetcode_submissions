# Write your MySQL query statement below
WITH RECURSIVE 
    Subtasks AS (
    SELECT t.task_id, id, 1 AS number
    FROM (SELECT DISTINCT subtasks_count AS id FROM Tasks) AS initial, Tasks t
    UNION
    SELECT t.task_id, st.id, st.number + 1
    FROM Subtasks st
    JOIN Tasks t ON st.id = t.subtasks_count
    WHERE st.number < t.subtasks_count
),
    t1 AS (
    SELECT DISTINCT s.task_id, number FROM Subtasks s, Tasks t
    WHERE id = subtasks_count
    ORDER BY s.task_id
    )

SELECT t1.task_id, number AS subtask_id FROM t1
WHERE (t1.task_id, number) NOT IN (SELECT * FROM Executed)
