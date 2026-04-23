-- Write your PostgreSQL query statement below
SELECT 
    COUNT(COALESCE(su.account_id, st.account_id)) AS accounts_count
FROM Subscriptions su
FULL OUTER JOIN Streams st
ON su.account_id = st.account_id
WHERE DATE '2021-01-01' BETWEEN start_date AND end_date
AND EXTRACT(YEAR FROM stream_date) <> 2021