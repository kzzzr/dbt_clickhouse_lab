{{
    config (
      engine='MergeTree()',
      order_by=['P_PARTKEY']
    )
}}

SELECT
    P_PARTKEY
    , P_NAME
    , P_MFGR
    , P_BRAND
    , P_TYPE
    , P_SIZE
    , P_CONTAINER
    , P_RETAILPRICE
    , P_COMMENT
FROM {{ source('dbgen', 'part') }}