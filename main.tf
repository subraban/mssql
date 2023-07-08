
resource "null_resource" "import_backup" {
  provisioner "local-exec" {
    command = "gcloud sql import sql instance1 gs://sqlservermedia/WideWorldImporters-Full.bak.bak --database=db1 --quiet"
  }
}
