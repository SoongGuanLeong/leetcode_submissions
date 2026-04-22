-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT * FROM Friends
    UNION
    SELECT user2, user1 FROM Friends
), B AS (
    SELECT user1,
        COUNT(user2) AS friends_cnt
    FROM A
    GROUP BY user1
)
SELECT user1,
    ROUND(friends_cnt * 100.0 / (SELECT COUNT(*) FROM B), 2) AS percentage_popularity
FROM B
ORDER BY user1

