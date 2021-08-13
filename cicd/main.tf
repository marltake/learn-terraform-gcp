terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials_file)

  project = var.project
  region  = var.region
  zone    = var.zone
}

variable "project" {}

variable "credentials_file" {}

variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-c"
}
