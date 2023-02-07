{{
    config (
      engine='MergeTree()',
      order_by='C_CUSTKEY'
    )
}}

SELECT
    C_CUSTKEY
    , C_NAME
    , C_ADDRESS
    , C_NATIONKEY
    , C_PHONE
    , C_ACCTBAL
    , C_MKTSEGMENT
    , C_COMMENT
FROM {{ source('dbgen', 'customer') }}