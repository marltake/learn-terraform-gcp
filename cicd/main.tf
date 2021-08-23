terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.default_location.region
  zone    = var.default_location.zone
}

variable "project" {
  default = "practice-cicd-mtk"
}

variable "default_location" {
  default = {
    region = "us-central1"
    zone   = "us-central1-c"
  }
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
