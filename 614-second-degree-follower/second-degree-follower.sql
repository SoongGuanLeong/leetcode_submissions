-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT followee, COUNT(1) AS no_of_follower
    FROM Follow
    GROUP BY followee
), B AS (
    SELECT follower, COUNT(1) AS no_of_followee
    FROM Follow
    GROUP BY follower
), C AS (
    SELECT 
        COALESCE(A.followee, B.follower) AS follower,
        no_of_follower,
        no_of_followee
    FROM A FULL OUTER JOIN B
    ON A.followee = B.follower
    ORDER BY 1
)
SELECT follower, no_of_follower AS num
FROM C
WHERE no_of_follower >= 1 AND no_of_followee >= 1