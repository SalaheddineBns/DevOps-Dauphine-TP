terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.10"
    }
  }

  backend "gcs" {
    bucket = "probable-sector-449113-b9-terraform-state"
    prefix = "terraform/state"
  }

  required_version = ">= 1.0"
}


provider "google" {
  project = "devops-dauphine-psl"
  region  = "us-central1"
}