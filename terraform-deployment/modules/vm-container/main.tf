
module "instance_template" {
  source  = "terraform-google-modules/vm/google//modules/instance_template"
  version = "~> 7.9"

  name_prefix  = "cloud-deployment-gce-java-temp-"
  source_image = var.source_image
  network      = var.vpc_network_self_link
  service_account = {
    email  = var.service_account.email
    scopes = var.service_account.scopes
  }
  tags           = var.tags
  metadata       = var.metadata
  startup_script = var.startup_script
  labels         = var.labels
}

module "mig" {
  source  = "terraform-google-modules/vm/google//modules/mig"
  version = "~> 8.0.1"

  project_id        = var.project_id
  region            = var.region
  mig_name          = var.mig_name
  hostname          = var.hostname == "" ? var.mig_name : var.hostname
  instance_template = module.instance_template.self_link
  target_size       = 1
  named_ports       = var.named_ports

  health_check = {
    type                = "tcp"
    port                = var.health_check_port
    proxy_header        = "NONE"
    request             = ""
    response            = ""
    check_interval_sec  = 5
    timeout_sec         = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    host                = ""
    initial_delay_sec   = 200
    request_path        = ""
    enable_logging      = true
  }
}
