resource "google_storage_bucket" "terraform-state-store" {
  name          = "marltake-practice-cicd-2"
  project       = "practice-cicd-mtk"
  location      = "us-central1"
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
