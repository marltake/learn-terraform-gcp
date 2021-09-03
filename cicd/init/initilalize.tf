data "google_billing_account" "account" {
  display_name = "marltake"
}
resource "google_project" "cicd" {
  name            = var.project
  project_id      = var.project
  billing_account = data.google_billing_account.account.id
}
locals {
  services = toset([
    "compute.googleapis.com",
    "containerregistry.googleapis.com",
    "run.googleapis.com",
    "iam.googleapis.com",
  ])
}
resource "google_project_service" "service" {
  for_each = local.services
  service  = each.value
}
resource "google_service_account" "deploy" {
  account_id   = "deploy"
  display_name = "lint and deploy (cicd)"
}
locals {
  roles = toset([
    "roles/iam.serviceAccountAdmin",
    "roles/iam.roleAdmin",
    "roles/iam.securityAdmin",
    "roles/storage.admin",
    #
    "roles/iam.serviceAccountUser",
    "roles/compute.admin",
    "roles/containerregistry.ServiceAgent",
    "roles/run.admin",
  ])
}
resource "google_project_iam_member" "deploy" {
  for_each = local.roles
  role     = each.value
  member   = "serviceAccount:${google_service_account.deploy.email}"
}
resource "google_storage_bucket" "terraform-state-store" {
  name          = "${var.project}-state"
  location      = var.default.region
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
