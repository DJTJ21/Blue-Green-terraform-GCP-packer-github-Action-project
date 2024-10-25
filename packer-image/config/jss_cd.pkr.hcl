

packer {
  required_plugins {
    googlecompute = {
      version = "1.0.16"
      source  = "github.com/hashicorp/googlecompute"
    }
  }
}

source "googlecompute" "main" {
  project_id            = "${var.project_id}"
  image_storage_locations = [
    "${var.region}",
  ]
  zone              = "${var.zone}"
  image_name        = "${var.img_name}"
  image_description = "${var.img_desc}"
  image_labels = {
    devops = "techworld-with-romuald"
  }
  image_family        = "jss-cd"
  source_image_family = "ubuntu-2204-lts"
  ssh_username        = "root"
  network             = "default"
  machine_type        = "n2-standard-2"
}

build {
  sources = ["sources.googlecompute.main"]

  provisioner "file" {
    sources     = [
      "${var.file_docker_compose_yml}",
    ]
    destination = "/"
  }

  provisioner "shell" {
    script             = "${var.file_install_package_sh}"
  }
}
