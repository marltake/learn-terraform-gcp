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
data "google_billing_account" "account" {
  display_name = "marltake"
}
resource "google_project" "init" {
  name            = var.project_id
  project_id      = var.project_id
  billing_account = data.google_billing_account.account.id
}
resource "google_storage_bucket" "terraform-state-store" {
  name          = "${var.project_id}-tfstate"
  location      = var.location.region
  storage_class = "REGIONAL"
  versioning {
    enabled = true
  }
  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      num_newer_versions = 5
    }
  }
}
terraform {
  backend "gcs" {
    bucket = "metabase-run-mysql-tfstate"
  }
}
