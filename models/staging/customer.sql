{{
    config (
      engine='MergeTree()',
      order_by='C_CUSTKEY'
    )
}}

select 

    *

from {{ source('dbgen', 'customer') }}