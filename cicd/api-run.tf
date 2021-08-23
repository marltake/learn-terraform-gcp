resource "google_cloud_run_service" "api-run" {
  name     = "api-run"
  location = var.default_location.region
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
resource "google_service_account" "invoke-api-service-account" {
  account_id   = "api-run-service-account"
  display_name = "Service Account for API Cloud Run"
}

# google_project_iam_member need iam.googleapis.com?
# google_cloud_run_service_iam_binding 権限不足 Error 403: Permission 'run.services.setIamPolicy' denied on
resource "google_cloud_run_service_iam_member" "invoke-api-member" {
  for_each = local.members
  service  = google_cloud_run_service.api-run.name
  location = google_cloud_run_service.api-run.location
  role     = "roles/viewer"
  member   = each.value
}

locals {
  members = toset([
    "serviceAccount:${google_service_account.invoke-api-service-account.email}",
  ])
}
