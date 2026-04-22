-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT country, winery, SUM(points) AS points,
        ROW_NUMBER() OVER(PARTITION BY country ORDER BY SUM(points) DESC, winery)
        AS row_num
    FROM Wineries
    GROUP BY 1, 2
)
SELECT country,
    MAX(CASE WHEN row_num = 1 THEN winery||' ('||points||')' END) AS top_winery,
    COALESCE(MAX(CASE WHEN row_num = 2 THEN winery||' ('||points||')' END), 'No second winery') 
    AS second_winery,
    COALESCE(MAX(CASE WHEN row_num = 3 THEN winery||' ('||points||')' END), 'No third winery')
    AS third_winery
FROM A
GROUP BY 1