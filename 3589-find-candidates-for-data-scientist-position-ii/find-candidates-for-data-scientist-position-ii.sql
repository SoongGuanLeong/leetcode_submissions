-- Write your PostgreSQL query statement below 
WITH mandatory AS (
    SELECT project_id, COUNT(1) AS requirement
    FROM Projects
    GROUP BY 1
), A AS (
    SELECT p.project_id AS project_id,
        p.skill AS skill,
        importance,
        candidate_id,
        proficiency,
        CASE WHEN proficiency > importance THEN 10
            WHEN proficiency < importance THEN -5
            ELSE 0
        END AS change,
        requirement
    FROM Projects p
    LEFT JOIN Candidates c
    ON p.skill = c.skill
    LEFT JOIN mandatory m
    ON p.project_id = m.project_id
), B AS (
    SELECT project_id, candidate_id, requirement,
        100 + SUM(change) AS score,
        COUNT(1) AS meet_requirement
    FROM A
    GROUP BY 1, 2, 3
), C AS (
    SELECT project_id, candidate_id, score,
        ROW_NUMBER() OVER(PARTITION BY project_id ORDER BY score DESC, candidate_id) AS rnk
    FROM B
    WHERE requirement = meet_requirement
)
SELECT project_id, candidate_id, score
FROM C
WHERE rnk = 1
ORDER BY 1
