-- Write your PostgreSQL query statement below
With courses_modified AS (
    SELECT *,
        COUNT(course_id) OVER(PARTITION BY major) AS total_courses
    FROM courses
), B AS (
    SELECT
        e.student_id AS student_id, 
        total_courses,
        COUNT(e.course_id) AS courses_taken
    FROM enrollments e
    LEFT JOIN students s
    ON e.student_id = s.student_id
    LEFT JOIN courses_modified c
    ON e.course_id = c.course_id
    WHERE grade = 'A'
    AND s.major = c.major
    GROUP BY 1, 2
    HAVING total_courses = COUNT(e.course_id)
)
SELECT student_id FROM B ORDER BY 1