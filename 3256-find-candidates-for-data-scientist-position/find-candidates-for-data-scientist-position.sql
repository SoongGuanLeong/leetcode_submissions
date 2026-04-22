-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT DISTINCT candidate_id
    FROM Candidates
    WHERE skill = 'Python'
), B AS (
    SELECT DISTINCT candidate_id
    FROM Candidates
    WHERE skill = 'Tableau'
), C AS (
    SELECT DISTINCT candidate_id
    FROM Candidates
    WHERE skill = 'PostgreSQL'
)
SELECT A.candidate_id
FROM A JOIN B
ON A.candidate_id = B.candidate_id
JOIN C
ON A.candidate_id = C.candidate_id
ORDER BY 1
