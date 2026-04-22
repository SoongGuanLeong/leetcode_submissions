-- Write your PostgreSQL query statement below
SELECT *,
    CASE WHEN dna_sequence ~ '^ATG.*$' THEN 1 ELSE 0 END AS has_start,
    CASE WHEN dna_sequence ~ '^.*(TAA|TAG|TGA)$' THEN 1 ELSE 0 END AS has_stop,
    CASE WHEN dna_sequence ~ '^.*ATAT.*$' THEN 1 ELSE 0 END AS has_atat,
    CASE WHEN dna_sequence ~ '^.*GGG.*$' THEN 1 ELSE 0 END AS has_ggg
FROM Samples
ORDER BY 1