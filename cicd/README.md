# logs for setup
## just make bucket for terraform state
```
shigenori.otake@GM10337 cicd % terraform show
# google_storage_bucket.terraform-state-store:
resource "google_storage_bucket" "terraform-state-store" {
    bucket_policy_only = false
    force_destroy      = false
    id                 = "marltake-practice-cicd"
    location           = "US-CENTRAL1"
    name               = "marltake-practice-cicd"
    project            = "practice-cicd-322801"
    requester_pays     = false
    self_link          = "https://www.googleapis.com/storage/v1/b/marltake-practice-cicd"
    storage_class      = "REGIONAL"
    url                = "gs://marltake-practice-cicd"

    lifecycle_rule {
        action {
            type = "Delete"
        }

        condition {
            age                   = 0
            is_live               = false
            matches_storage_class = []
            num_newer_versions    = 5
            with_state            = "ANY"
        }
    }

    versioning {
        enabled = true
    }
}
```
