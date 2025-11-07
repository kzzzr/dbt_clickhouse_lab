{{
    config (
      engine='MergeTree()',
      order_by=['']
    )
}}

SELECT
    toYear(O_ORDERDATE) AS O_ORDERYEAR
    , O_ORDERSTATUS
    , O_ORDERPRIORITY
    , count(DISTINCT O_ORDERKEY) AS num_orders
    , count(DISTINCT C_CUSTKEY) AS num_customers
    , sum(L_EXTENDEDPRICE * L_DISCOUNT) AS revenue
FROM {{ ref('stg_lineitem') }} AS l
    INNER JOIN {{ ref('stg_orders') }} AS o ON o.O_ORDERKEY = l.L_ORDERKEY
    INNER JOIN {{ ref('stg_customer') }} AS c ON c.C_CUSTKEY = o.O_CUSTKEY-- PLEASE USE dbt's ref('') to ensure valid DAG execution!
WHERE 1=1
GROUP BY
    toYear(O_ORDERDATE)
    , O_ORDERSTATUS
    , O_ORDERPRIORITY

