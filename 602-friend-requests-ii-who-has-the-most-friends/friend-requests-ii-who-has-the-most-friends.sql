# Write your MySQL query statement below
SELECT requester_id AS id, COUNT(requester_id) AS num
FROM
    (SELECT requester_id, accepter_id
    FROM RequestAccepted
    UNION
    SELECT accepter_id AS requester_id, requester_id AS accepter_id
    FROM RequestAccepted) AS a
GROUP BY requester_id
ORDER BY num DESC LIMIT 1;