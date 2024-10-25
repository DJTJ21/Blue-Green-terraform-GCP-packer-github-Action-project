

terraform {
  required_version = ">= 0.13"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.57"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}
