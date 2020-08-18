resource "google_compute_network" "cloudiap_network" {
  name                    = "${var.project_prefix}-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "cloudiap_subnetwork" {
  name          = "${var.project_prefix}-subnetwork"
  ip_cidr_range = "10.8.0.0/16"
  region        = var.default_region
  network       = google_compute_network.cloudiap_network.id
}

### Cloud IAP経由で gcloud ssh するための設定
resource "google_compute_firewall" "cloudiap" {
  name    = "allow-ingress-from-iap"
  network = google_compute_network.cloudiap_network.name

  allow {
    protocol = "tcp"
    ports    = ["22", "3389"]
  }

  source_ranges = ["35.235.240.0/20"]
  target_tags   = [var.tag_tunnel]
}

### グローバルHTTP(S)負荷分散からのアクセス許可設定
resource "google_compute_firewall" "allow_http" {
  name    = "allow-http-access"
  network = google_compute_network.cloudiap_network.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  target_tags   = [var.tag_allow_http]
}

### ロードバランサー用の外部IP
resource "google_compute_global_address" "app" {
  name = "${var.project_prefix}-app-ip"
}