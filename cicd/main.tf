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
  zone    = var.zone
}

variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-c"
}
