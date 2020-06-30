terraform {
  backend "gcs" {
    credentials = "./gcp-bigip-test-terraform-account.json"
    bucket      = "cloudiap-test-tfstate-kuvd6hgnbr"
    prefix      = "terraform/state"
  }
}