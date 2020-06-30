provider "google" {
  credentials = file("gcp-bigip-test-terraform-account.json")
  project     = var.project-name
  region      = var.default-region
}