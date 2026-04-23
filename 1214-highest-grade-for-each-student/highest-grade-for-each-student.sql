# Write your MySQL query statement below
SELECT student_id, course_id, grade
FROM
    (SELECT student_id, course_id, grade, 
        DENSE_RANK()OVER(PARTITION BY student_id ORDER BY grade DESC, course_id) AS rnk
    FROM Enrollments
    ORDER BY student_id) AS t1
WHERE rnk = 1