terraform {
  backend "gcs" {
    bucket = "teckworld-bucket"
    prefix = "terraform/state"
  }
}
