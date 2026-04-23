-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT 
        R1.user_id AS user1_id,
        R2.user_id AS user2_id,
        COUNT(*) AS common_followers
    FROM Relations R1 JOIN Relations R2
    ON R1.follower_id = R2.follower_id
    AND R1.user_id < R2.user_id
    GROUP BY 1, 2
)
SELECT user1_id, user2_id
FROM A
WHERE common_followers = (SELECT MAX(common_followers) FROM A)
