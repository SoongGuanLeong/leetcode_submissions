-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT COALESCE(b.book_id, o.book_id) AS book_id,
        name,
        available_from,
        order_id,
        quantity,
        dispatch_date
    FROM Books b FULL OUTER JOIN Orders o
    ON b.book_id = o.book_id
    WHERE available_from <= DATE '2019-06-23' - INTERVAL '1 MONTH'
), B AS (
    SELECT book_id, name, 
        SUM(CASE WHEN dispatch_date >= DATE '2019-06-23' - INTERVAL '1 YEAR'
                THEN quantity ELSE 0 END) AS quantity
    FROM A
    GROUP BY book_id, name
)
SELECT book_id, name FROM B WHERE quantity < 10

