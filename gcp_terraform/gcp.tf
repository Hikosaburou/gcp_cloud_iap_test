provider "google" {
  project = var.project_name
  region  = var.default_region
}

provider "google-beta" {
  project = var.project_name
  region  = var.default_region
}