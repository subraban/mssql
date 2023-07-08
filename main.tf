resource "google_sql_database_instance" "instance" {
  name             = "instance3"
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

resource "google_sql_database" "database" {
  name     = "db1"
  instance = google_sql_database_instance.instance.name
}
resource "null_resource" "import_backup" {
  provisioner "local-exec" {
    command = <<EOT
      gcloud auth activate-service-account --key-file=creds.json
      echo Y | gcloud sql import sql instance3 gs://sqlservermedia/WideWorldImporters-Full.bak.bak --database=db1 --quiet
     
    EOT
}
}

resource "google_sql_database_instance" "instance" {
   name    = "instance3"
 
  settings {
    ip_configuration {
      authorized_networks {
        name         = "Allow Local IP"
        value        = "171.76.81.135"
        
      }
    }
  }
}
