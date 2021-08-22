terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  project = "practice-cicd-mtk"
  region  = "us-central1"
  zone    = "us-central1-c"
}

locals {
  services = toset([
    "compute.googleapis.com",
    "containerregistry.googleapis.com",
    "run.googleapis.com",
  ])
}

resource "google_project_service" "service" {
  for_each = local.services
  service  = each.value
}
