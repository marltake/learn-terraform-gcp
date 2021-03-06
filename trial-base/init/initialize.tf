data "google_billing_account" "account" {
  display_name = "marltake"
}
resource "google_project" "base" {
  name       = var.project
  project_id = var.project
  # https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project
  billing_account = data.google_billing_account.account.id
}
# https://cloud.google.com/blog/ja/products/gcp/guest-post-using-terraform-to-manage-google-cloud-platform-infrastructure-as-code
# even in blog but no module google_project_services in terraform
locals {
  services = toset([
    "iam.googleapis.com", # Manages identity and access control
    #
    "compute.googleapis.com",           # VM(GCE)
    "containerregistry.googleapis.com", # Conttainer Reigstry
    "run.googleapis.com",               # Cloud Run
    # "cloudresourcemanager.googleapis.com",  # Cloud Resoure Manager
    # "container.googleapis.com",  # GKE(k8s)
    # "file.googleapis.com",  # Cloud Firestore
    # "anthos.googleapis.com",  # Anthos ## billing
    # "redis.googleapis.com",  # redis (on memory)
    # "spanner.googleapis.com",  # Cloud Spanner
    # "cloudscheduler.googleapis.com",  # Cloud Scheduler
    # "cloudtasks.googleapis.com",  # Cloud Tasks
    # "workflows.googleapis.com",  # Workflows
    # "dns.googleapis.com",  # Cloud DNS
    # "artifactregistry.googleapis.com",  # Artifact Registry (for build)
    # "composer.googleapis.com",  # Cloud Composer
    # "datastream.googleapis.com",  # Datastream (Change Data Capture)
    # "cloudiot.googleapis.com",  # Cloud IoT
    # "bigquery.googleapis.com",  # BIg Query
    # "datacatalog.googleapis.com",  # Cloud Data Catalog
    # "datafusion.googleapis.com",  # Cloud Data Fusion
    # "healthcare.googleapis.com",  # Cloud Healthcare (bridge)
    # "lifesciences.googleapis.com",  # Cloud Life Sciences
    # "",  # Vertex AI
    # "",  # Data Labeling
  ])
}
resource "google_project_service" "base" {
  for_each = local.services
  service  = each.value
}
resource "google_service_account" "deploy" {
  account_id = "deploy"
  # https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account
  display_name = "lint and deploy (cicd)"
}
locals {
  roles = toset([
    "roles/iam.serviceAccountAdmin", # ???????????? ????????????????????????
    "roles/iam.roleAdmin",           # ?????????????????????
    "roles/iam.securityAdmin",       # ???????????????????????????
    "roles/storage.admin",           # ????????????????????????
    #
    "roles/iam.serviceAccountUser",         # ???????????? ??????????????? ????????????
    "roles/compute.admin",                  # Compute ?????????
    "roles/containerregistry.ServiceAgent", # Container Registry ???????????? ??????????????????
    "roles/run.admin",                      # Cloud Run ?????????
    "roles/datastore.owner",                # Cloud Datastore ????????????
    # "roles/appengine.appAdmin",      # App Engine ?????????
    # "roles/appengine.appCreator",    # App Engine ?????????
    # "roles/pubsub.admin",            # Pub/Sub ?????????
  ])
}
resource "google_project_iam_member" "deploy" {
  for_each = local.roles
  role     = each.value
  member   = "serviceAccount:${google_service_account.deploy.email}"
  # https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam

}
resource "google_storage_bucket" "terraform-state-store" {
  name          = "${var.project}-state"
  location      = var.default.region
  storage_class = "REGIONAL"
  # https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket

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
