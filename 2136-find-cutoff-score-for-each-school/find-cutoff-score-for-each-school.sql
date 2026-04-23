-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT * 
    FROM Schools CROSS JOIN Exam
    WHERE capacity >= student_count
), B AS (
    SELECT *,
        ROW_NUMBER() OVER(PARTITION BY school_id ORDER BY student_count DESC, score) AS row_num
    FROM A
), C AS (
    SELECT school_id, score FROM B 
    WHERE row_num = 1
)
SELECT COALESCE(C.school_id, s.school_id) AS school_id,
    COALESCE(score, -1) AS score
FROM C FULL OUTER JOIN Schools s
ON C.school_id = s.school_id
order by 1
