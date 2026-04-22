-- Write your PostgreSQL query statement below
WITH A AS (
    SELECT item_type, COUNT(*) AS cnt, SUM(square_footage) AS total_footage
    FROM Inventory 
    GROUP BY 1
)
SELECT item_type,
    CASE WHEN item_type = 'prime_eligible' 
            THEN FLOOR(500000 / total_footage) * cnt
        ELSE FLOOR((500000 
            - FLOOR(500000 / (SELECT total_footage FROM A WHERE item_type = 'prime_eligible')) 
            * (SELECT total_footage FROM A WHERE item_type = 'prime_eligible'))
            / total_footage) * cnt
    END AS item_count
FROM A
