-- models/staging/stg_lineitem.sql

SELECT
    L_ORDERKEY,
    L_EXTENDEDPRICE,
    L_DISCOUNT
FROM
    {{ ref('lineitems') }}
