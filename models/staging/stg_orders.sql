-- models/staging/stg_orders.sql

SELECT
    O_ORDERKEY,
    O_CUSTKEY,
    O_ORDERDATE,
    O_ORDERSTATUS,
    O_ORDERPRIORITY
FROM
    {{ ref('orders') }}
