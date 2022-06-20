ARG DBT_VERSION=1.0.0
FROM fishtownanalytics/dbt:${DBT_VERSION}

ARG ADAPTER_VERSION=1.1.0.2
RUN set -ex \
    && pip install dbt-clickhouse==${ADAPTER_VERSION}

WORKDIR /usr/app/

ENV DBT_PROFILES_DIR=.

ENTRYPOINT ["tail", "-f", "/dev/null"]
