SELECT
    (count(*) = 3) AS assert -- ИСПРАВЛЕНО
FROM {{ ref('f_orders_stats') }}
HAVING assert NOT IN (1)
