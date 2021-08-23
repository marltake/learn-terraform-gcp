resource "google_cloud_run_service" "api-run" {
  name     = "api-run"
  location = provider.google.region
  template {
    spec {
      containers {
        image = "asia.gcr.io/${provider.google.project}/hello"
        resources {
          limits = { "cpu" : "1000m", "memory" : "1024Mi" }
        }
      }
    }
  }
  traffic {
    percent         = 100
    latest_revision = true
  }
  autogenerate_revision_name = true
  lifecycle {
    ignore_changes = [
      template[0].metadata[0].annotations
    ]
  }
}

# IAM
resource "google_service_account" "api-run-service-account" {
  account_id   = "api-run-service-account"
  display_name = "Service Account for API Cloud Run"
}

resource "google_project_iam_member" "inference-invoker-iam" {
  role   = "roles/run.invoker"
  member = "serviceAccount:${google_service_account.api-run-service-account.email}"
}
