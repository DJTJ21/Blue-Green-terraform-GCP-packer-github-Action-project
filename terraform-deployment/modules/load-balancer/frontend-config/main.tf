

resource "google_compute_url_map" "cloud_deployment" {
  name            = "cloud-deployment-gce-java-${var.name_suffix}"
  default_service = var.backend_bucket_id
  host_rule {
    path_matcher = "app"
    hosts = [
      "*",
    ]
  }
  path_matcher {
    name            = "app"
    default_service = var.backend_bucket_id
    path_rule {
      paths = [
        "/${var.resource_path}/*",
      ]
      service = var.backend_bucket_id
    }
    path_rule {
      paths = [
        "*",
      ]
      route_action {
        dynamic "weighted_backend_services" {
          for_each = var.weighted_backend_services
          iterator = entry
          content {
            backend_service = entry.value["backend_service_id"]
            weight          = lookup(entry.value, "weight", floor(1000 / length(var.weighted_backend_services)))
          }
        }
      }
    }
  }
}

resource "google_compute_target_http_proxy" "cloud_deployment" {
  name    = "cloud-deployment-gce-java-${var.name_suffix}"
  url_map = google_compute_url_map.cloud_deployment.self_link
}

resource "google_compute_global_forwarding_rule" "cloud_deployment" {
  name                  = "cloud-deployment-gce-java-${var.name_suffix}"
  target                = google_compute_target_http_proxy.cloud_deployment.self_link
  ip_address            = var.global_address
  port_range            = "80"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  labels                = var.labels
}
