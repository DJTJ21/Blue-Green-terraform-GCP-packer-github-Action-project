
variable "project_id" {
  description = "Google Cloud project ID."
  type        = string
  validation {
    condition     = var.project_id != ""
    error_message = "Error: project_id is required"
  }
}

variable "region" {
  description = "Google Cloud region where the cloud resource will be created."
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "Google cloud zone where the resources will be created."
  type        = string
  default     = "us-central1-a"
}

variable "bucket_location" {
  description = "Bucket location where the uploaded files will be stored."
  type        = string
  default     = "US"

  validation {
    condition     = contains(["ASIA", "EU", "US"], var.bucket_location)
    error_message = "Allowed values for type are \"ASIA\", \"EU\", \"US\"."
  }
}

variable "source_image" {
  description = "The source image used to create the instance."
  type        = string
  default     = "projects/techworld-438822/global/images/techworld-vm-image"
}

variable "labels" {
  type        = map(string)
  description = "A map of key/value label pairs to assign to the cloud resources."
  default = {
    app = "cloud-deployment-gce-java"
  }
}

variable "data_init_bucket_name" {
  description = "Name of the Cloud Storage bucket that store the archive file for initialization."
  type        = string
  default     = "jss-resources"
}

variable "data_init_archive_file_name" {
  description = "Name of the archive file that contains the initialization data."
  type        = string
  default     = "initialization.tar.gz"
}
