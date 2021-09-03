terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "<4"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.default.region
  zone    = var.default.zone
}

variable "project" {
  default = "trial-base-mtk"
}

variable "default" {
  default = {
    region = "us-central1"
    zone   = "us-central1-c"
  }
}
