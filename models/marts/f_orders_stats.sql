-- models/marts/f_orders_stats.sql
SELECT
    toYear(o.O_ORDERDATE) AS O_ORDERYEAR,
    o.O_ORDERSTATUS,
    o.O_ORDERPRIORITY,
    count(DISTINCT o.O_ORDERKEY) AS num_orders,
    count(DISTINCT c.C_CUSTKEY) AS num_customers,
    sum(l.L_EXTENDEDPRICE * (1 - l.L_DISCOUNT)) AS revenue
FROM
    {{ ref('stg_orders') }} AS o
LEFT JOIN {{ ref('stg_lineitem') }} AS l 
    ON o.O_ORDERKEY = l.L_ORDERKEY
LEFT JOIN {{ ref('stg_customer') }} AS c 
    ON o.O_CUSTKEY = c.C_CUSTKEY
WHERE
    1 = 1
GROUP BY
    1, 2, 3
ORDER BY
    1, 2, 3
