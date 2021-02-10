output "codecard-web_compute_ip_addr" {
  value = oci_core_instance.export_codecard-web.public_ip
}

output "codecard_adw_apex_url" {
  value = lookup(oci_database_autonomous_database.export_codecard.connection_urls[0],"apex_url")
}

output "objectstorage_namespace" {
  value = var.bucket_ns
}

output "region" {
  value = var.region
}

output "sqldev_url" {
  value = replace(lookup(oci_database_autonomous_database.export_codecard.connection_urls[0],"sql_dev_web_url"),"admin","cc")
}
