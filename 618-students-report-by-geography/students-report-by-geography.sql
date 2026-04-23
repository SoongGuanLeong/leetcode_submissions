-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT CASE WHEN continent = 'America' THEN name END AS "America",
        ROW_NUMBER() OVER(ORDER BY name) AS row_num
    FROM Student
    WHERE (CASE WHEN continent = 'America' THEN name END) IS NOT NULL 
), B AS (
    SELECT CASE WHEN continent = 'Asia' THEN name END AS "Asia",
    ROW_NUMBER() OVER(ORDER BY name) AS row_num 
    FROM Student
    WHERE (CASE WHEN continent = 'Asia' THEN name END) IS NOT NULL 
), C AS (
    SELECT CASE WHEN continent = 'Europe' THEN name END AS "Europe",
    ROW_NUMBER() OVER(ORDER BY name) AS row_num
    FROM Student
    WHERE (CASE WHEN continent = 'Europe' THEN name END) IS NOT NULL 
)
SELECT "America", "Asia", "Europe"
FROM A 
FULL OUTER JOIN B ON A.row_num = B.row_num
FULL OUTER JOIN C ON A.row_num = C.row_num





