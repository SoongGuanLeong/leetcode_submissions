-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT book_id,
        COUNT(1) AS cnt
    FROM borrowing_records
    WHERE return_date IS NULL
    GROUP BY 1
)
SELECT 
    b.book_id,
    title,
    author,
    genre,
    publication_year,
    cnt AS current_borrowers
FROM A JOIN library_books b
ON A.book_id = b.book_id
WHERE cnt = total_copies
ORDER BY 6 DESC, 2