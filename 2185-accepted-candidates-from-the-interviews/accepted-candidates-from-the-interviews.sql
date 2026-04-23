-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT candidate_id, years_of_exp, SUM(score) AS total_score 
    FROM Candidates c FULL OUTER JOIN Rounds r
    ON c.interview_id = r.interview_id
    WHERE years_of_exp >= 2
    GROUP BY 1, 2
    HAVING SUM(score) > 15
)
SELECT candidate_id FROM A