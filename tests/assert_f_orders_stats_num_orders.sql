SELECT
    (sum(num_orders) = 1500000) AS assert
FROM {{ ref('f_orders_stats') }}
HAVING assert NOT IN (1)
