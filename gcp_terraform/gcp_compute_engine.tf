resource "google_compute_instance" "default" {
  name         = "${var.project-code}-vm"
  machine_type = var.instance-type
  zone         = var.default-zone

  tags = [var.tag-tunnel]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.cloudiap_subnetwork.name
    // External IPは不要なので access_config は設定しない
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}