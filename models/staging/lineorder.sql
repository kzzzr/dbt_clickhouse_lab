{{
    config (
      engine='MergeTree()',
      order_by=['LO_ORDERDATE', 'LO_ORDERKEY'],
      partition_by='toYear(LO_ORDERDATE)'
    )
}}

select

    *

from {{ source('dbgen', 'lineorder') }}
