{{
    config (
      engine='MergeTree()',
      order_by=['S_SUPPKEY']
    )
}}

SELECT
    S_SUPPKEY
    , S_NAME
    , S_ADDRESS
    , S_NATIONKEY
    , S_PHONE
    , S_ACCTBAL
    , S_COMMENT
FROM {{ source('dbgen', 'supplier') }}