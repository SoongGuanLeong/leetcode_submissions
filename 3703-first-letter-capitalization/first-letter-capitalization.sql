-- Write your PostgreSQL query statement below
SELECT content_id,
    content_text AS original_text,
    -- there is a func built-in https://www.postgresql.org/docs/9.1/functions-string.html
    initcap(content_text) AS converted_text
FROM user_content