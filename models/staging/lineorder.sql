{{
    config (
      engine='MergeTree()',
      order_by=['LO_ORDERDATE', 'LO_ORDERKEY'],
      partition_by='toYear(LO_ORDERDATE)'
    )
}}

select

    {{ dbt_utils.star(source('dbgen', 'lineorder')) }}

from {{ source('dbgen', 'lineorder') }}
