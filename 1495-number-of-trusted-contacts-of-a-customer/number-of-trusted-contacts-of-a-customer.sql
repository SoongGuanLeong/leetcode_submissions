-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT *,
        CASE WHEN contact_email IN (SELECT email FROM Customers) 
            THEN 1 ELSE 0 
        END AS trusted
    FROM Contacts
), B AS (
    SELECT 
        COALESCE(c.customer_id, A.user_id) AS customer_id,
        customer_name, email, contact_name, contact_email, trusted
    FROM Customers c FULL OUTER JOIN A
    ON c.customer_id = A.user_id
), C AS (
    SELECT customer_id, customer_name,
        COALESCE(COUNT(DISTINCT contact_email), 0) AS contacts_cnt,
        COALESCE(SUM(trusted), 0) AS trusted_contacts_cnt
    FROM B
    GROUP BY 1, 2
)
SELECT invoice_id, customer_name, price, contacts_cnt, trusted_contacts_cnt
FROM Invoices i LEFT JOIN C
ON i.user_id = C.customer_id
ORDER BY 1