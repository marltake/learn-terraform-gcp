resource "google_service_account" "metabase" {
  account_id   = "metabase"
  display_name = "Service Account for Metabase"
}