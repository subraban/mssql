resource "google_sql_database_instance" "instance" {
  name             = "instance1"
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


resource "null_resource" "import_backup" {
  provisioner "local-exec" {
    command = <<EOT
      gcloud auth activate-service-account --key-file=creds.json
      echo Y | gcloud sql import sql instance1 gs://sqlservermedia/WideWorldImporters-Full.bak.bak --database=db1 --quiet
      gcloud sql instances patch instance1 --authorized-networks="171.76.81.135"
    EOT
}
}
