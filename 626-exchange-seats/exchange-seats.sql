# Write your MySQL query statement below
SELECT
    IF (id % 2 = 0, id - 1, 
        IF(id + 1 <= (SELECT MAX(id) FROM seat), id + 1, id)) AS id, student
FROM Seat
GROUP BY id
ORDER BY id;