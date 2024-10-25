

resource "google_sql_database_instance" "main" {
  name             = "cloud-deployment-gce-java-db"
  database_version = "MYSQL_8_0"
  region           = var.region
  settings {
    availability_type = var.availability_type
    backup_configuration {
      enabled            = true
      binary_log_enabled = true
    }
    location_preference {
      zone = var.zone
    }
    tier      = "db-custom-2-4096"
    disk_type = "PD_SSD"
    disk_size = 20
    ip_configuration {
      private_network = var.vpc_network_self_link
      ipv4_enabled    = false
    }
  }

  deletion_protection = false
  depends_on          = [google_service_networking_connection.private_vpc]
}

resource "google_sql_database" "main" {
  name      = "cloud_deployment_gce_db" # equal to api/src/main/resources/db/schema.sql
  charset   = "utf8"
  collation = "utf8_general_ci"
  instance  = google_sql_database_instance.main.name
}

resource "google_sql_user" "main" {
  name     = "cloud-deployment-gce-java"
  instance = google_sql_database_instance.main.name
  password = random_password.sql_password.result
  host     = "%"
}

resource "google_compute_global_address" "sql" {
  name          = "cloud-deployment-gce-java-db-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 20
  network       = var.vpc_network_self_link
}

resource "random_password" "sql_password" {
  length           = 20
  min_lower        = 4
  min_numeric      = 4
  min_special      = 4
  min_upper        = 4
  override_special = "!@#*()-_=+[]{}:?"
}

resource "google_secret_manager_secret" "sql_password" {
  secret_id = "cloud-deployment-gce-java-db-password"
  project   = var.project_id

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "sql_password" {
  secret      = google_secret_manager_secret.sql_password.id
  enabled     = true
  secret_data = random_password.sql_password.result
}

resource "google_secret_manager_secret_iam_member" "sql_password" {
  project   = google_secret_manager_secret.sql_password.project
  secret_id = google_secret_manager_secret.sql_password.secret_id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${var.service_account}"
}

resource "google_service_networking_connection" "private_vpc" {
  network = var.vpc_network_self_link
  service = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [
    google_compute_global_address.sql.name,
  ]
}
