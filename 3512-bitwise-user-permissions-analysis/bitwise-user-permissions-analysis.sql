-- Write your PostgreSQL query statement below
SELECT
    bit_and(permissions::bit(8))::INT AS common_perms,
    bit_or(permissions::bit(8))::INT AS any_perms
FROM user_permissions