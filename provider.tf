provider "google" {
  project     = var.project_id
  region      = "us-central1"
}
terraform {
  backend "gcs" {
    bucket = "cloudbuildproject-449316-terraform-state"
    prefix = "Devops-Dauphine-TP"
  }
}