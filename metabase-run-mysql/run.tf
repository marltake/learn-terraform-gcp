resource "google_cloud_run_service" "metabase" {
  name     = "metabase"
  location = var.location.region
  template {
    spec {
      containers {
        image = "asia.gcr.io/${var.project_id}/metabase"
        resources {
          limits = { "cpu" : "1000m", "memory" : "4096Mi" }
        }
        ports {
          name           = "http1"
          container_port = 3000
        }
      }
      service_account_name = google_service_account.metabase.email
    }
    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale" = "1"
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
      template[0].spec[0].containers,
      template[0].metadata[0].annotations,
    ]
  }
}
