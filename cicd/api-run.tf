resource "google_cloud_run_service" "api-run" {
  name     = "api-run"
  location = var.default.region
  template {
    spec {
      containers {
        image = "gcr.io/${var.project}/hello"
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
  # autogenerate_revision_name = true  # why this is invalid?
  lifecycle {
    ignore_changes = [
      template[0].metadata[0].annotations
    ]
  }
}
# IAM
resource "google_service_account" "api-invoker" {
  account_id   = "api-invoker"
  display_name = "Service Account for call API Cloud Run"
}
# google_project_iam_member need iam.googleapis.com?
# google_cloud_run_service_iam_binding 権限不足 Error 403: Permission 'run.services.setIamPolicy' denied on
resource "google_cloud_run_service_iam_binding" "invokeer" {
  service  = google_cloud_run_service.api-run.name
  location = google_cloud_run_service.api-run.location
  role     = "roles/run.invoker"
  members = [
    "serviceAccount:${google_service_account.api-invoker.email}",
  ]
}
