resource "google_storage_bucket" "terraform-state-store" {
  name          = "marltake-practice-cicd"
  project       = var.project
  location      = var.region
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
