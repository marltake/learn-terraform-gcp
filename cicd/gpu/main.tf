terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~>3.5"
    }
  }
}
provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}
data "google_billing_account" "account" {
  display_name = "marltake"
}
resource "google_project" "gpu_decoy" {
  name            = var.project
  project_id      = var.project
  billing_account = data.google_billing_account.account.id
}
locals {
  services = toset([
    "compute.googleapis.com",
    "iam.googleapis.com",
  ])
}
resource "google_project_service" "service" {
  for_each = local.services
  service  = each.value
}
variable "project" { default = "trial-gpu-mtk" }
variable "region" { default = "asia-northeast1" }
variable "zone" { default = "asia-northeast1-c" }
