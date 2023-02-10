# Development

1. Clone this repo & open with IDE (e.g. [VS Code](https://code.visualstudio.com/))

2. Prepare your development credentials for Clickhouse:

    - DBT_HOST
    - DBT_USER
    - DBT_PASSWORD

- [ ] [Fork this repository]()
- [ ] [Deploy Clickhouse](#1-deploy-clickhouse)
- [ ] [Configure Developer Environment](#2-configure-developer-environment)
- [ ] [Check database connection](#3-check-database-connection)
- [ ] [Stage data sources with dbt macro](#4-stage-data-sources-with-dbt-macro)
- [ ] [Deploy DWH](#5-deploy-dwh)
- [ ] [Model read-optimized data mart](#6-model-read-optimized-data-mart)
- [ ] [Create PR and make CI tests pass]()


- [x] .gitignore (+ terraform)
- [x] terraform return cluster host (don't hardcode)
- [x] secrets handling (use .env)
- [ ] Github Codespace experience
- [ ] Test assignment using Github Actions
- [ ] ? asciinema record

## 1. Deploy Clickhouse

1. Get familiar with Managed Clickhouse Management Console

    ![](./docs/clickhouse_management_console.gif)

1. Install and configure `yc` CLI: [Getting started with the command-line interface by Yandex Cloud](https://cloud.yandex.com/en/docs/cli/quickstart#install)

    ```bash
    yc init
    ```

1. Populate `.env` file

    `.env` is used to store secrets as environment variables.

    Copy template file [.env.template](./.env.template) to `.env` file:
    ```bash
    cp .env.template .env
    ```

    Open file in editor and set your own values.

    > ❗️ Never commit secrets to git    

1. Set environment variables:

    ```bash
    export YC_TOKEN=$(yc iam create-token)
    export YC_CLOUD_ID=$(yc config get cloud-id)
    export YC_FOLDER_ID=$(yc config get folder-id)
    export $(xargs <.env)
    ```

    <details><summary>Alternatively, install on local machine</summary>
    <p>

    ```bash
    terraform init
    terraform validate
    terraform fmt
    terraform plan
    terraform apply
    ```

    Store terraform output values as Environment Variables:
    ```bash
    export CLICKHOUSE_HOST=$(terraform output -raw clickhouse_host_fqdn)
    ```

    - [EN] Reference: [Getting started with Terraform by Yandex Cloud](https://cloud.yandex.com/en/docs/tutorials/infrastructure-management/terraform-quickstart)
    - [RU] Reference: [Начало работы с Terraform by Yandex Cloud](https://cloud.yandex.ru/docs/tutorials/infrastructure-management/terraform-quickstart)


## 2. Configure Developer Environment

Install dbt environment with [Docker](https://docs.docker.com/desktop/#download-and-install):

```bash
# build & run container
docker-compose build
docker-compose up -d

# alias docker exec command
alias dbt="docker-compose exec dev dbt"
```

<details><summary>Alternatively, install dbt on local machine</summary>
<p>

[Install dbt](https://docs.getdbt.com/dbt-cli/install/overview) and [configure profile](https://docs.getdbt.com/dbt-cli/configure-your-profile) manually by yourself. By default, dbt expects the `profiles.yml` file to be located in the `~/.dbt/` directory.

Use this [template](./profiles.yml) and enter your own credentials.
</p>
</details>

## 3. Check database connection

Make sure dbt can connect to your target database:

```bash
dbt debug
```

[Configure JDBC (DBeaver) connection](https://cloud.yandex.ru/docs/managed-clickhouse/operations/connect#connection-ide):

```
port=8443
socket_timeout=300000
ssl=true
sslrootcrt=<path_to_cert>
```

If any errors check ENV values are present:
```
docker-compose exec dev env | grep DBT_
```

## 4. Stage data sources with dbt macro

Source data will be staged as EXTERNAL TABLES (S3) using dbt macro [init_s3_sources](./macros/init_s3_sources.sql):

```bash
dbt run-operation init_s3_sources
```

Statements will be run separately from a list to avoid error:

```
DB::Exception: Syntax error (Multi-statements are not allowed)
```

## 5. Deploy DWH

1. Describe sources in [sources.yml](./models/sources/sources.yml) files

1. Install dbt packages

    ```bash
    dbt deps
    ```


1. Build staging models:

    ```bash
    dbt build -s tag:staging
    ```

    Check model configurations: `engine`, `order_by`, `partition_by`

1. Prepare wide table (Data Mart)

    Join all the tables into one [lineorder_flat](./models/):

    ```bash
    dbt build -s lineorder_flat
    ```

    Pay attentions to models being tested for keys being unique, not null.
## 6. Model read-optimized Data Mart

Turn the following SQL into [f_orders_stats](./models/marts/f_orders_stats.sql) dbt model:

```sql
SELECT
    toYear(O_ORDERDATE) AS O_ORDERYEAR
    , O_ORDERSTATUS
    , O_ORDERPRIORITY
    , count(DISTINCT O_ORDERKEY) AS num_orders
    , count(DISTINCT C_CUSTKEY) AS num_customers
    , sum(L_EXTENDEDPRICE * L_DISCOUNT) AS revenue
FROM lineorder_flat
WHERE 1=1
GROUP BY
    toYear(O_ORDERDATE)
    , O_ORDERSTATUS
    , O_ORDERPRIORITY
```

Make sure the tests pass:

```bash
dbt test -s f_orders_stats
```

## Shut down your cluster

⚠️ Attention! Always delete resources after you finish your work!

![image](https://user-images.githubusercontent.com/34193409/214896888-3c6db293-8f1c-4931-8277-b2e4137f30a3.png)

```bash
cd ./terraform
terraform destroy
```

## Lesson plan

- [ ] Deploy Clickhouse
- [ ] Init dbt project
- [ ] Install environment – dbt + clickhouse dependency
- [ ] Configure project (dbt_project)
- [ ] Configure connection (profile)
- [ ] Prepare source data files (S3)
- [ ] Configure EXTERNAL TABLES (S3)
- [ ] Describe sources in .yml files
- [ ] Basic dbt models and configurations
- [ ] Code compilation + debugging
- [ ] Prepare STAR schema
- [ ] Querying results
- [ ] Testing & Documenting your project
