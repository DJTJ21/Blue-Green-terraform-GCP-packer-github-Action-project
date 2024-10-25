

resource "google_compute_health_check" "cloud_deployment" {
  name                = "cloud-deployment-gce-java-${var.name_suffix}"
  timeout_sec         = 10
  check_interval_sec  = 20
  unhealthy_threshold = 2
  tcp_health_check {
    port = var.health_check_port
  }
  log_config {
    enable = true
  }
}

resource "google_compute_backend_service" "cloud_deployment" {
  name                  = "cloud-deployment-gce-java-${var.name_suffix}"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  port_name             = var.port_name
  dynamic "backend" {
    for_each = var.backends
    iterator = entry
    content {
      group = entry.value["group_url"]
    }
  }
  health_checks = [google_compute_health_check.cloud_deployment.self_link]
}
