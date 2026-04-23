# Write your MySQL query statement below
SELECT transaction_id
FROM
    (SELECT transaction_id, day, amount,
        DENSE_RANK()OVER(PARTITION BY DATE(day) ORDER BY amount DESC) AS rnk
    FROM Transactions) AS t1
WHERE rnk = 1
ORDER BY transaction_id
