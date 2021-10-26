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