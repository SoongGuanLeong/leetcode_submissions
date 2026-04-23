# Write your MySQL query statement below
WITH t3 AS (
    SELECT DISTINCT student_id FROM
        (SELECT e.exam_id, student_id, score, MaxScore, MinScore
        FROM Exam e JOIN
            (SELECT exam_id, MAX(score) AS MaxScore, MIN(score) As MinScore
            FROM Exam
            GROUP BY exam_id) AS t1
        ON e.exam_id = t1.exam_id) AS t2
    WHERE score = MinScore
    OR score = MaxScore
)

SELECT student_id, student_name FROM Student
WHERE student_id NOT IN (SELECT student_id FROM t3)
AND student_id IN (SELECT student_id FROM Exam)







