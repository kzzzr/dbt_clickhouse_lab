-- models/staging/stg_customer.sql

SELECT
    C_CUSTKEY,
    C_NAME
FROM
    {{ ref('customers') }}
