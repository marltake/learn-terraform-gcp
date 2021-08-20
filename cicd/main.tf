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
  region  = var.region
}

variable "region" {
  default = "us-central1"
}

resource "google_project_service" "service" {
  service = "compute.googleapis.com"
}
