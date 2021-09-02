{{
    config (
      engine='MergeTree()',
      order_by=['S_SUPPKEY']
    )
}}

select * from {{ source('dbgen', 'supplier') }}