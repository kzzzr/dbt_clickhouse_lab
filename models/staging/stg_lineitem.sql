{{
    config (
      engine='MergeTree()',
      order_by=['L_SHIPDATE', 'L_ORDERKEY'],
      partition_by='toYear(L_SHIPDATE)'
    )
}}

SELECT
    {{ dbt_utils.generate_surrogate_key(['L_ORDERKEY', 'L_LINENUMBER']) }} AS L_ITEMKEY
    , L_ORDERKEY
    , L_PARTKEY
    , L_SUPPKEY
    , L_LINENUMBER
    , L_QUANTITY
    , L_EXTENDEDPRICE
    , L_DISCOUNT
    , L_TAX
    , L_RETURNFLAG
    , L_LINESTATUS
    , L_SHIPDATE
    , L_COMMITDATE
    , L_RECEIPTDATE
    , L_SHIPINSTRUCT
    , L_SHIPMODE
    , L_COMMENT
FROM {{ source('dbgen', 'lineitem') }}
