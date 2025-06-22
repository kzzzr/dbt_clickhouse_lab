#!/bin/bash
echo "Starting post-create script..."

echo "Upgrading pip, setuptools, and wheel..."
python -m pip install --upgrade pip setuptools wheel

echo "Clearing pip cache..."
pip cache purge

echo "Installing dbt-clickhouse and compatible snowplow-tracker..."
pip install dbt-clickhouse==1.7.4 "snowplow-tracker>=0.10.0,<0.11.0" --force-reinstall --no-cache-dir
# Важно: кавычки вокруг "snowplow-tracker>=0.10.0,<0.11.0" могут быть нужны,
# чтобы shell не интерпретировал > и < как перенаправление.

echo "Checking dbt installation..."
dbt --version || echo "dbt --version FAILED"

echo "Listing installed dbt packages and snowplow-tracker..."
pip freeze | grep -E 'dbt|snowplow-tracker'

echo "Post-create script finished."