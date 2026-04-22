-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT SUM(CASE WHEN score >= 90 THEN 1 ELSE 0 END) AS n_cnt
    FROM NewYork
), B AS (
    SELECT SUM(CASE WHEN score >= 90 THEN 1 ELSE 0 END) AS c_cnt
    FROM California
)
SELECT
    CASE WHEN n_cnt > c_cnt THEN 'New York University'
        WHEN n_cnt < c_cnt THEN 'California University'
        ELSE 'No Winner'
    END AS winner
FROM A, B