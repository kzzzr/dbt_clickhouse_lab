{{
    config (
      engine='MergeTree()',
      order_by=['LO_ORDERDATE', 'LO_ORDERKEY'],
      partition_by='toYear(LO_ORDERDATE)'
    )
}}

SELECT

    {{ dbt_utils.surrogate_key(['LO_CUSTKEY', 'C_CUSTKEY', 'S_SUPPKEY']) }}
    ,{{ dbt_utils.star(ref('lineorder')) }}
    ,{{ dbt_utils.star(ref('customer')) }}
    ,{{ dbt_utils.star(ref('supplier')) }}
    ,{{ dbt_utils.star(ref('part')) }}

FROM {{ ref('lineorder') }} AS l
INNER JOIN {{ ref('customer') }} AS c ON c.C_CUSTKEY = l.LO_CUSTKEY
INNER JOIN {{ ref('supplier') }} AS s ON s.S_SUPPKEY = l.LO_SUPPKEY
INNER JOIN {{ ref('part') }} AS p ON p.P_PARTKEY = l.LO_PARTKEY

