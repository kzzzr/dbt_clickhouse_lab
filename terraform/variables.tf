variable "admin_password" {
  description = "Clickhouse admin password"
  type        = string
  sensitive   = true
#   default     = "password"
}

data "yandex_mdb_clickhouse_cluster" "clickhouse_starschema" {
  name = "clickhouse_starschema"
}

output "clickhouse_host_fqdn" {
  value = data.yandex_mdb_clickhouse_cluster.clickhouse_starschema.host[0].fqdn
}
