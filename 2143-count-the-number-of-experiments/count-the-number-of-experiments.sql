-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT * FROM 
    (SELECT UNNEST(ARRAY['IOS', 'Android', 'Web']) AS platform) t1
    CROSS JOIN
    (SELECT UNNEST(ARRAY['Programming', 'Sports', 'Reading']) AS experiment_name) t2
)
SELECT
    A.platform AS platform,
    A.experiment_name AS experiment_name,
    COUNT(experiment_id) AS num_experiments
FROM A LEFT JOIN Experiments e
ON A.platform = e.platform
AND A.experiment_name = e.experiment_name
GROUP BY 1, 2