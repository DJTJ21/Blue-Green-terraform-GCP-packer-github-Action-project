variable "project_id" {
  type = string
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "zone" {
  type    = string
  default = "us-central1-a"
}

variable "img_name" {
  type = string
}

variable "img_desc" {
  type = string
}

variable "file_install_package_sh" {
  type    = string
  default = "../tools/install_package.sh"
}

variable "file_docker_compose_yml" {
  type    = string
  default = "../tools/docker-compose.yml"
}
