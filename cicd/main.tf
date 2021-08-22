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

resource "google_project_service" "service" {
  service = "compute.googleapis.com"
}
