-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT * FROM Friendship
    UNION
    SELECT user2_id, user1_id FROM Friendship
), B AS (
    SELECT user1_id,
        COALESCE(A.user2_id, l.user_id) AS user2_id,
        page_id
    FROM A
    FULL OUTER JOIN Likes l
    ON A.user2_id = l.user_id
), C AS (
    SELECT * 
    FROM B
    WHERE (user1_id, page_id) NOT IN 
        (SELECT user_id, page_id FROM Likes)
)
SELECT user1_id AS user_id,
    page_id,
    COUNT(1) AS friends_likes
FROM C
GROUP BY 1, 2