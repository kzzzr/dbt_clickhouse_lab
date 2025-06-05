{% macro init_s3_sources() -%}

    {% set sources = [
        'DROP TABLE IF EXISTS src_customer'
        , 'CREATE TABLE IF NOT EXISTS src_customer
        (
                C_CUSTKEY       UInt32,
                C_NAME          String,
                C_ADDRESS       String,
                C_NATIONKEY     UInt32,
                C_PHONE         String,
                C_ACCTBAL       Decimal(15,2),
                C_MKTSEGMENT    LowCardinality(String),
                C_COMMENT       String   
        )
        ENGINE = S3(\'https://storage.yandexcloud.net/ch-data-course/customer.tbl\', \'CustomSeparated\')
        SETTINGS
            format_custom_field_delimiter=\'|\'
            ,format_custom_escaping_rule=\'CSV\'
            ,format_custom_row_after_delimiter=\'|\n\'        
        '
        , 'DROP TABLE IF EXISTS src_orders'
        , 'CREATE TABLE src_orders
        (
            O_ORDERKEY             UInt32,
            O_CUSTKEY              UInt32,
            O_ORDERSTATUS            LowCardinality(String),            
            O_TOTALPRICE             Decimal(15,2),     
            O_ORDERDATE            Date,
            O_ORDERPRIORITY            LowCardinality(String),
            O_CLERK          String,
            O_SHIPPRIORITY           UInt8,  
            O_COMMENT               String
        )
        ENGINE = S3(\'https://storage.yandexcloud.net/ch-data-course/orders.tbl\', \'CustomSeparated\')
        SETTINGS
            format_custom_field_delimiter=\'|\'
            ,format_custom_escaping_rule=\'CSV\'
            ,format_custom_row_after_delimiter=\'|\n\'                
        '
        , 'DROP TABLE IF EXISTS src_lineitem'
        , 'CREATE TABLE src_lineitem
        (
            L_ORDERKEY             UInt32,
            L_PARTKEY              UInt32,
            L_SUPPKEY              UInt32,
            L_LINENUMBER           UInt8,
            L_QUANTITY             Decimal(15,2),
            L_EXTENDEDPRICE        Decimal(15,2),            
            L_DISCOUNT             Decimal(15,2),
            L_TAX                  Decimal(15,2),
            L_RETURNFLAG            LowCardinality(String),
            L_LINESTATUS            LowCardinality(String),
            L_SHIPDATE              Date,
            L_COMMITDATE            Date,
            L_RECEIPTDATE           Date,            
            L_SHIPINSTRUCT          String,
            L_SHIPMODE             LowCardinality(String),
            L_COMMENT               String
        )
        ENGINE = S3(\'https://storage.yandexcloud.net/ch-data-course/lineitem.tbl\', \'CustomSeparated\')
        SETTINGS
            format_custom_field_delimiter=\'|\'
            ,format_custom_escaping_rule=\'CSV\'
            ,format_custom_row_after_delimiter=\'|\n\'                
        '
        , 'DROP TABLE IF EXISTS src_part'
        , 'CREATE TABLE src_part
        (
                P_PARTKEY       UInt32,
                P_NAME          String,
                P_MFGR          LowCardinality(String),
                P_BRAND         LowCardinality(String),
                P_TYPE          LowCardinality(String),
                P_SIZE          UInt8,
                P_CONTAINER     LowCardinality(String),
                P_RETAILPRICE       Decimal(15,2),
                P_COMMENT       String
        )
        ENGINE = S3(\'https://storage.yandexcloud.net/ch-data-course/part.tbl\', \'CustomSeparated\')
        SETTINGS
            format_custom_field_delimiter=\'|\'
            ,format_custom_escaping_rule=\'CSV\'
            ,format_custom_row_after_delimiter=\'|\n\'                
        '
        , 'DROP TABLE IF EXISTS src_supplier'
        , 'CREATE TABLE src_supplier
        (
                S_SUPPKEY       UInt32,
                S_NAME          String,
                S_ADDRESS       String,
                S_NATIONKEY     UInt32,
                S_PHONE         String,
                S_ACCTBAL       Decimal(15,2),
                S_COMMENT       String
        )
        ENGINE = S3(\'https://storage.yandexcloud.net/ch-data-course/supplier.tbl\', \'CustomSeparated\')
        SETTINGS
            format_custom_field_delimiter=\'|\'
            ,format_custom_escaping_rule=\'CSV\'
            ,format_custom_row_after_delimiter=\'|\n\'                
        '
    ] %}

    {% for src in sources %}
        {% set statement = run_query(src) %}
    {% endfor %}

{{ print('Initialized source tables – TPCH (S3)') }}    

{%- endmacro %}