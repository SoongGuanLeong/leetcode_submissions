-- Write your PostgreSQL query statement below
SELECT 
    STRING_AGG(
        CASE WHEN factor > 0 THEN '+' ELSE '' END
        || factor 
        || CASE WHEN power <> 0 THEN 'X' ELSE '' END
        || CASE WHEN power > 1 THEN '^' || power ELSE '' END,
        '' ORDER BY POWER DESC
    ) || '=0'
    AS equation
FROM Terms