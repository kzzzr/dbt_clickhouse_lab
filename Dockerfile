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

# Set default directory for dbt profiles
ENV DBT_PROFILES_DIR=.
