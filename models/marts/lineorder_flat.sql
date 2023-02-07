{{
    config (
      engine='MergeTree()',
      order_by=['L_SHIPDATE', 'L_ORDERKEY'],
      partition_by='toYear(L_SHIPDATE)'
    )
}}

SELECT

      L_ITEMKEY
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
    
    , O_ORDERKEY
    , O_CUSTKEY
    , O_ORDERSTATUS
    , O_TOTALPRICE
    , O_ORDERDATE
    , O_ORDERPRIORITY
    , O_CLERK
    , O_SHIPPRIORITY
    , O_COMMENT

    , C_CUSTKEY
    , C_NAME
    , C_ADDRESS
    , C_NATIONKEY
    , C_PHONE
    , C_ACCTBAL
    , C_MKTSEGMENT
    , C_COMMENT

    , S_SUPPKEY
    , S_NAME
    , S_ADDRESS
    , S_NATIONKEY
    , S_PHONE
    , S_ACCTBAL
    , S_COMMENT

    , P_PARTKEY
    , P_NAME
    , P_MFGR
    , P_BRAND
    , P_TYPE
    , P_SIZE
    , P_CONTAINER
    , P_RETAILPRICE
    , P_COMMENT    

FROM {{ ref('stg_lineitem') }} AS l
    INNER JOIN {{ ref('stg_orders') }} AS o ON o.O_ORDERKEY = l.L_ORDERKEY
    INNER JOIN {{ ref('stg_customer') }} AS c ON c.C_CUSTKEY = o.O_CUSTKEY
    INNER JOIN {{ ref('stg_supplier') }} AS s ON s.S_SUPPKEY = l.L_SUPPKEY
    INNER JOIN {{ ref('stg_part') }} AS p ON p.P_PARTKEY = l.L_PARTKEY
