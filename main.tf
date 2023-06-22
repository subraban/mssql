resource "google_sql_database_instance" "instance" {
  name             = "sqlserver-instance"
  region           = "us-central1"
  database_version = "SQLSERVER_2017_EXPRESS"
  root_password    = "Prakash@123"
  settings {
    tier = "db-custom-2-7680"
  }
  # set `deletion_protection` to true, will ensure that one cannot accidentally delete this instance by
  # use of Terraform whereas `deletion_protection_enabled` flag protects this instance at the GCP level.
  deletion_protection = false
}

resource "google_sql_database" "gcloudsql" {
  name       = "gcloudsql"
  
  instance   = google_sql_database_instance.instance.name
  charset    = var.db_charset
  collation  = var.db_collation
  depends_on = [null_resource.module_depends_on, google_sql_database_instance.default, google_sql_user.default, google_sql_user.additional_users]
}
