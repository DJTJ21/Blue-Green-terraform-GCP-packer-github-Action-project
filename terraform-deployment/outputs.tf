
output "backend_bucket_name" {
  description = "The name of the backend bucket used for Cloud CDN"
  value       = google_compute_backend_bucket.cdn.name
}

output "bucket_name" {
  description = "Bucket name"
  value       = module.storage.bucket_name
}

output "blue_mig_self_link" {
  description = "Self link of the blue version instance group"
  value       = module.vm_container_blue.mig_self_link
}

output "green_mig_self_link" {
  description = "Self link of the green version instance group"
  value       = module.vm_container_green.mig_self_link
}

output "blue_mig_load_balancer_ip" {
  description = "IP address of the blue version instance group"
  value       = "http://${module.load_balancer_frontend_config_blue.lb_external_ip}"
}

output "green_mig_load_balancer_ip" {
  description = "IP address of the green version instance group"
  value       = "http://${module.load_balancer_frontend_config_green.lb_external_ip}"
}

output "user_mig_load_balancer_ip" {
  description = "IP address of the user instance group"
  value       = "http://${module.load_balancer_frontend_config_user.lb_external_ip}"
}
