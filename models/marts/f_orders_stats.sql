{{
    config (
      engine='MergeTree()',
      order_by=['']
    )
}}

SELECT DISTINCT O_ORDERSTATUS
FROM f_lineorder_flat
