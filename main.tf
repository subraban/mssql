resource "google_sql_database_instance" "instance" {
  name             = "instance1"
  region           = "us-central1"
  database_version = "SQLSERVER_2017_EXPRESS"
  root_password    = "Prakash@123"
  settings {
    tier = "db-custom-2-7680"
     ip_configuration {
      authorized_networks {
        name         = "Allow Local IP"
        value        = "171.76.81.135"
        
      }
    }
  }
  # set `deletion_protection` to true, will ensure that one cannot accidentally delete this instance by
  # use of Terraform whereas `deletion_protection_enabled` flag protects this instance at the GCP level.
  deletion_protection = false
}

resource "google_sql_database" "database" {
  name     = "db1"
  instance = google_sql_database_instance.instance.name
}

