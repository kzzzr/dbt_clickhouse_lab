{{
    config (
      engine='MergeTree()',
      order_by=['P_PARTKEY']
    )
}}

select * from {{ source('dbgen', 'part') }}