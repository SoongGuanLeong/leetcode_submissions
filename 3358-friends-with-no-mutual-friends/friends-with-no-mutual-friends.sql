-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT user_id1 AS user_id, user_id2 AS friend_id FROM Friends
    UNION
    SELECT user_id2, user_id1 FROM Friends
), B AS (
   SELECT
        a1.user_id, 
        COALESCE(a1.friend_id, a2.user_id) AS friend_id,
        a2.friend_id AS friend_friend_id,
        a3.user_id AS user_friend_id,
        CASE WHEN a2.friend_id = a3.user_id THEN 1 ELSE 0 END AS is_mutual_friend
    FROM A a1 JOIN A a2
    ON a1.friend_id = a2.user_id
    JOIN A a3
    ON a1.user_id = a3.friend_id
), C AS (
    SELECT user_id, friend_id, SUM(is_mutual_friend) AS has_mutual_friend
    FROM B 
    GROUP BY 1, 2
)
SELECT user_id AS user_id1, friend_id AS user_id2
FROM C
WHERE has_mutual_friend = 0
AND (user_id, friend_id) IN (SELECT * FROM Friends)
ORDER BY 1, 2