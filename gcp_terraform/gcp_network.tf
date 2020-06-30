resource "google_compute_network" "cloudiap_network" {
  name                    = "${var.project-code}-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "cloudiap_subnetwork" {
  name          = "${var.project-code}-subnetwork"
  ip_cidr_range = "10.8.0.0/16"
  region        = var.default-region
  network       = google_compute_network.cloudiap_network.id
}

resource "google_compute_firewall" "cloudiap" {
  name    = "allow-ingress-from-iap"
  network = google_compute_network.cloudiap_network.name

  allow {
    protocol = "tcp"
    ports    = ["22", "3389"]
  }

  source_ranges = ["35.235.240.0/20"]
  source_tags   = [var.tag-tunnel]
}