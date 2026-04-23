# Write your MySQL query statement below
SELECT user AS results
FROM
    (SELECT user, COUNT(movie)
    FROM
        (SELECT title AS movie, name AS user, rating, created_at
        FROM Movies m, Users u, MovieRating r
        WHERE m.movie_id = r.movie_id AND u.user_id = r.user_id) AS a
    GROUP BY user
    ORDER BY COUNT(movie) DESC, user
    LIMIT 1) AS b
UNION ALL

SELECT movie AS results
FROM
(SELECT movie, AVG(rating)
FROM (SELECT title AS movie, name AS user, rating, created_at
        FROM Movies m, Users u, MovieRating r
        WHERE m.movie_id = r.movie_id AND u.user_id = r.user_id
        AND YEAR(created_at)=2020 AND MONTH(created_at) = 2) AS c
GROUP BY movie
ORDER BY AVG(rating) DESC, movie
LIMIT 1) AS d
