{{
    config (
      engine='MergeTree()',
      order_by='C_CUSTKEY'
    )
}}

select 

  {{ dbt_utils.star(from=source('dbgen', 'customer')) }}

from {{ source('dbgen', 'customer') }}