-- Write your PostgreSQL query statement below
SELECT age_bucket, 
    ROUND(
        SUM(CASE WHEN activity_type = 'send' THEN time_spent ELSE 0 END) * 100.0
        / SUM(time_spent)
        , 2)
    AS send_perc,
    ROUND(
        SUM(CASE WHEN activity_type = 'open' THEN time_spent ELSE 0 END) * 100.0
        / SUM(time_spent) 
        , 2)
    AS open_perc
FROM Age ag LEFT JOIN Activities ac
ON ag.user_id = ac.user_id
GROUP BY 1
