-- Write your PostgreSQL query statement below
WITH courses_modified AS (
    SELECT *,
        SUM(CASE WHEN LOWER(mandatory) = 'yes' THEN 1 ELSE 0 END)
            OVER(PARTITION BY major)
        AS mandatory_cnt
    FROM courses
), A AS (
    SELECT 
        e.student_id AS student_id,
        e.course_id AS course_id,
        s.major AS student_major, 
        c.major AS course_major, 
        mandatory,
        mandatory_cnt,
        grade,
        GPA
    FROM enrollments e
    LEFT JOIN courses_modified c
    ON e.course_id = c.course_id
    LEFT JOIN students s
    ON e.student_id = s.student_id
), B AS (
    SELECT student_id,
        CASE WHEN 
                COUNT(*) FILTER(WHERE student_major=course_major 
                            AND LOWER(mandatory)='yes' 
                            AND grade='A') 
                = MAX(mandatory_cnt) FILTER (
                                        WHERE student_major = course_major
                                        AND LOWER(mandatory) = 'yes')
                AND COUNT(*) FILTER(WHERE student_major=course_major 
                                AND LOWER(mandatory)='no' 
                                AND grade IN ('A', 'B')) >= 2
                AND AVG(GPA) >= 2.5
        THEN 1 ELSE 0
        END AS flag
    FROM A
    GROUP BY student_id
)
SELECT student_id
FROM B
WHERE flag=1
ORDER BY student_id