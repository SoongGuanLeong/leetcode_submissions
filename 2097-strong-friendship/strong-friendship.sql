-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT * FROM Friendship
    UNION ALL
    SELECT user2_id, user1_id FROM Friendship
), B AS (
    SELECT
        COALESCE(F1.user1_id, F2.user1_id) AS user1_id,
        COALESCE(F1.user2_id, F3.user2_id) AS user2_id,
        F2.user2_id AS user1_friend,
        F3.user1_id AS user2_friend
    FROM A F1 JOIN A F2
    ON F1.user1_id = F2.user1_id
    JOIN A F3
    ON F1.user2_id = F3.user2_id
)
SELECT user1_id, user2_id,
    SUM(CASE WHEN user1_friend = user2_friend THEN 1 ELSE 0 END) AS common_friend 
FROM B
GROUP BY 1,2
HAVING SUM(CASE WHEN user1_friend = user2_friend THEN 1 ELSE 0 END) >= 3
AND user1_id < user2_id
