-- Write your PostgreSQL query statement below
SELECT
    SPLIT_PART(email, '@', 2) AS email_domain,
    COUNT(1)
FROM Emails
WHERE email ~ '@[a-z]+\.com$'
GROUP BY 1
ORDER BY 1