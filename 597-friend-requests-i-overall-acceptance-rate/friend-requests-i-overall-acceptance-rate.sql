-- Write your PostgreSQL query statement below
WITH r AS (
    SELECT COUNT(DISTINCT(sender_id, send_to_id)) FROM FriendRequest
),
a AS (
    SELECT COUNT(DISTINCT(requester_id, accepter_id)) FROM RequestAccepted 
)
SELECT 
    ROUND(COALESCE(a.count::DECIMAL / NULLIF(r.count, 0), 0), 2)
    AS accept_rate 
FROM r, a