-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT * FROM Calls
    UNION ALL
    SELECT recipient_id, caller_id, call_time FROM Calls
), B AS (
    SELECT *,
        ROW_NUMBER() OVER(PARTITION BY caller_id, DATE(call_time) ORDER BY call_time) AS row_num_asc,
        ROW_NUMBER() OVER(PARTITION BY caller_id, DATE(call_time) ORDER BY call_time DESC) AS row_num_desc
    FROM A
), C AS (
    SELECT * FROM B WHERE row_num_asc = 1
), D AS (
    SELECT * FROM B WHERE row_num_desc = 1  
) 
SELECT DISTINCT COALESCE(C.caller_id, D.caller_id) AS user_id
FROM C JOIN D
ON C.caller_id = D.caller_id
AND DATE(C.call_time) = DATE(D.call_time)
AND C.recipient_id = D.recipient_id
