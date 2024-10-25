

module "load_balancer_frontend_config_user" {
  depends_on = [
    module.project_services,
  ]
  source = "./modules/load-balancer/frontend-config"

  name_suffix       = "user"
  backend_bucket_id = google_compute_backend_bucket.cdn.id
  resource_path     = local.resource_path
  global_address    = module.global_addresses.addresses[2]
  weighted_backend_services = [
    {
      backend_service_id = module.load_balancer_backend_config_blue.backend_service_id
    }
  ]
  labels = var.labels
}
