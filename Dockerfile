ARG DBT_VERSION=1.0.0
FROM fishtownanalytics/dbt:${DBT_VERSION}

# Terraform configuration file
# COPY terraformrc root/.terraformrc

# Install utils
RUN apt -y update \
    && apt -y upgrade \
    && apt -y install curl wget gpg unzip

# Install dbt adapter
RUN set -ex \
    && python -m pip install --upgrade pip setuptools \
    && python -m pip install --upgrade dbt-clickhouse

# Install yc CLI
RUN curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | \
    bash -s -- -a

# Install Terraform
ARG TERRAFORM_VERSION=1.4.6
RUN curl -sL https://hashicorp-releases.yandexcloud.net/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform.zip \
    && unzip terraform.zip \
    && install -o root -g root -m 0755 terraform /usr/local/bin/terraform \
    && rm -rf terraform terraform.zip


# Подключить DEB-репозиторий.
RUN apt-get update && \
    apt-get install wget --yes apt-transport-https ca-certificates dirmngr && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 8919F6BD******** && \
    echo "deb https://packages.clickhouse.com/deb stable main" | tee \
    /etc/apt/sources.list.d/clickhouse.list && \
    # Установить зависимости.
    apt-get update && \
    apt-get install wget clickhouse-client --yes && \
    # Загрузить файл конфигурации для clickhouse-client.
    mkdir --parents ~/.clickhouse-client && \
    wget "https://storage.yandexcloud.net/doc-files/clickhouse-client.conf.example" \
         --output-document ~/.clickhouse-client/config.xml && \
    # Получить SSL-сертификаты.
    mkdir --parents /usr/local/share/ca-certificates/Yandex/ && \
    wget "https://storage.yandexcloud.net/cloud-certs/RootCA.pem" \
         --output-document /usr/local/share/ca-certificates/Yandex/RootCA.crt && \
    wget "https://storage.yandexcloud.net/cloud-certs/IntermediateCA.pem" \
         --output-document /usr/local/share/ca-certificates/Yandex/IntermediateCA.crt && \
    chmod 655 \
         /usr/local/share/ca-certificates/Yandex/RootCA.crt \
         /usr/local/share/ca-certificates/Yandex/IntermediateCA.crt && \
    update-ca-certificates

# Set default directory for dbt profiles
ENV DBT_PROFILES_DIR=.

