# Write your MySQL query statement below
WITH Failed1 AS (
    SELECT "failed" AS period_state, fail_date AS date FROM Failed
    WHERE YEAR(fail_date) = 2019
    ),
    Succeeded1 AS (
    SELECT "succeeded" AS period_state, success_date AS date FROM Succeeded
    WHERE YEAR(success_date) = 2019
    ),
    t1 AS (
    SELECT * FROM Failed1
    UNION
    SELECT * FROM Succeeded1
    ORDER BY date
    ),
    t2 AS (
    SELECT period_state, date,
        ROW_NUMBER()OVER(ORDER BY date) AS overall,
        ROW_NUMBER()OVER(PARTITION BY period_state ORDER BY date) AS rnk
    FROM t1
    ORDER BY date
    ),
    t3 AS (
    SELECT period_state, date, overall - rnk AS dategroup FROM t2
    )

SELECT period_state, MIN(date) AS start_date, MAX(date) AS end_date
FROM t3
GROUP BY period_state, dategroup
ORDER BY start_date