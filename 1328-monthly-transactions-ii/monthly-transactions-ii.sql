-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT 
        COALESCE(t.id, c.trans_id) AS id,
        country, state, amount,
        TO_CHAR(t.trans_date, 'YYYY-MM') AS trans_date,
        TO_CHAR(c.trans_date, 'YYYY-MM') AS chargebacks_date
    FROM Transactions t 
    FULL OUTER JOIN Chargebacks c
    ON t.id = c.trans_id
), B AS (
    SELECT trans_date AS month, country,
        SUM(CASE WHEN state='approved' THEN 1 ELSE 0 END) AS approved_count,
        SUM(CASE WHEN state='approved' THEN amount ELSE 0 END) AS approved_amount
    FROM A
    GROUP BY trans_date, country
), C AS (
    SELECT chargebacks_date AS month, country,
        SUM(CASE WHEN chargebacks_date IS NOT NULL THEN 1 ELSE 0 END) AS chargeback_count,
        SUM(CASE WHEN chargebacks_date IS NOT NULL THEN amount ELSE 0 END) AS chargeback_amount
    FROM A
    WHERE chargebacks_date IS NOT NULL
    GROUP BY chargebacks_date, country
), D AS (
    SELECT 
        COALESCE(B.month, C.month) AS month,
        COALESCE(B.country, C.country) AS country,
        COALESCE(approved_count, 0) AS approved_count,
        COALESCE(approved_amount, 0) AS approved_amount,
        COALESCE(chargeback_count, 0) AS chargeback_count,
        COALESCE(chargeback_amount, 0) AS chargeback_amount
    FROM B FULL OUTER JOIN C
    ON B.month = C.month AND B.country=C.country
)
-- SELECT * FROM D
-- WHERE (approved_count, approved_amount, chargeback_count, chargeback_amount) != (0,0,0,0)
SELECT *
FROM D
WHERE approved_count      <> 0
   OR approved_amount     <> 0
   OR chargeback_count    <> 0
   OR chargeback_amount   <> 0;