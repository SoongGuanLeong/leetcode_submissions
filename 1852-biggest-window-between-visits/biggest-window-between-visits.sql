# Write your MySQL query statement below
SELECT user_id, MAX(w) AS biggest_window
FROM
    (SELECT user_id, visit_date,
        DATEDIFF(IFNULL(
            LEAD(visit_date, 1)
            OVER(PARTITION BY user_id
            ORDER BY visit_date), "2021-01-01"), visit_date) AS w
    FROM UserVisits) AS t1
GROUP BY user_id
