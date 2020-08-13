### global load balancing resources

resource "google_compute_global_forwarding_rule" "default" {
  name       = "${var.project_prefix}-global-rule"
  target     = google_compute_target_https_proxy.default.id
  port_range = "443"
}

resource "google_compute_managed_ssl_certificate" "default" {
  provider = google-beta

  name = "${var.project_prefix}-cert"

  managed {
    domains = ["${var.lb_host}."]
  }
}

resource "google_compute_target_https_proxy" "default" {
  provider = google-beta

  name        = "${var.project_prefix}-target-proxy"
  url_map     = google_compute_url_map.default.id
  ssl_certificates = [google_compute_managed_ssl_certificate.default.id]
}

resource "google_compute_url_map" "default" {
  provider = google-beta

  name            = "${var.project_prefix}-url-map-target-proxy"
  default_service = google_compute_backend_service.default.id

  host_rule {
    hosts        = [var.lb_host]
    path_matcher = "allpaths"
  }

  path_matcher {
    name            = "allpaths"
    default_service = google_compute_backend_service.default.id

    path_rule {
      paths   = ["/*"]
      service = google_compute_backend_service.default.id
    }
  }
}

resource "google_compute_backend_service" "default" {
  name        = "${var.project_prefix}-backend"
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 10
  backend {
    group = google_compute_instance_group_manager.appserver.instance_group
  }
  health_checks = [google_compute_http_health_check.default.id]
}

resource "google_compute_http_health_check" "default" {
  name               = "${var.project_prefix}-check-backend"
  request_path       = "/"
  check_interval_sec = 5
  timeout_sec        = 1
}