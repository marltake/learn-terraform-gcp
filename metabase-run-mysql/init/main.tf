terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~>3.5"
    }
  }
  required_version = "~> 1.0"
}
provider "google" {
  project = var.project_id
  region  = var.location.region
  zone    = var.location.zone
}
variable "project_id" {
  default = "metabase-run-mysql"
}
variable "location" {
  default = {
    region = "asia-northeast1"
    zone   = "asia-northeast1-c"
  }
}
