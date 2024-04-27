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
FROM {{ ref('f_lineorder_flat') }}
WHERE 1=1
GROUP BY
    toYear(O_ORDERDATE)
    , O_ORDERSTATUS
    , O_ORDERPRIORITY
