### https://cloud.google.com/iap/docs/tutorial-gce?hl=ja を参考に設定する


### ロードバランサ配下のインスタンスグループ向けのインスタンステンプレート
resource "google_compute_instance_template" "instance_template" {
  name_prefix  = "${var.project_prefix}-template-"
  machine_type = var.instance_type
  region       = var.default_region

  tags                    = [var.tag_tunnel, var.tag_allow_http]
  metadata_startup_script = file("./example_startup_script.sh")

  disk {
    source_image = "debian-cloud/debian-9"
    auto_delete  = true
    boot         = true  
  }

  network_interface {
    subnetwork = google_compute_subnetwork.cloudiap_subnetwork.name
    access_config {}
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

### マネージドインスタンスグループ向けのヘルスチェック設定 (Auto Healing)
resource "google_compute_health_check" "autohealing" {
  name                = "${var.project_prefix}autohealing-health-check"
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 10 # 50 seconds

  http_health_check {
    port         = "80"
  }
}

### マネージドインスタンスグループ設定
resource "google_compute_instance_group_manager" "appserver" {
  name = "${var.project_prefix}-mig"

  base_instance_name = "${var.project_prefix}-app"
  zone               = var.default_zone ### マルチゾーン設定の方法がわからん……

  version {
    instance_template = google_compute_instance_template.instance_template.id
  }

  target_size = 3

  auto_healing_policies {
    health_check      = google_compute_health_check.autohealing.id
    initial_delay_sec = 300
  }
}