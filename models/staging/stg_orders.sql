{{
    config (
      engine='MergeTree()',
      order_by=['O_ORDERKEY']
    )
}}


SELECT
    O_ORDERKEY
    , O_CUSTKEY
    , O_ORDERSTATUS
    , O_TOTALPRICE
    , O_ORDERDATE
    , O_ORDERPRIORITY
    , O_CLERK
    , O_SHIPPRIORITY
    , O_COMMENT
FROM {{ source('dbgen', 'orders') }}