locals {
  services = toset([
    # "cloudbilling.googleapis.com",  # Cloud Billing API (manually, inter project)
    "iam.googleapis.com", # Manages identity and access control
    # "containerregistry.googleapis.com",    # Conttainer Reigstry
    # "run.googleapis.com",                  # Cloud Run
    # "cloudresourcemanager.googleapis.com", # Cloud Resoure Manager (need for adding roles/bigquery.jobUser)
    # "bigquery.googleapis.com",             # BIg Query
    # "compute.googleapis.com",              # VM(GCE)
    # "iap.googleapis.com",                  # Cloud Identity-Aware Proxy API  いこう
    # "sqladmin.googleapis.com",             # Cloud SQL Admin API
    # "container.googleapis.com",            # GKE(k8s)
    # "bigqueryreservation.googleapis.com",  # BigQuery Reservation API
    # "file.googleapis.com",                 # Cloud Firestore
    # "anthos.googleapis.com",               # Anthos ## billing
    # "redis.googleapis.com",                # redis (on memory)
    # "spanner.googleapis.com",              # Cloud Spanner
    # "cloudscheduler.googleapis.com",       # Cloud Scheduler
    # "cloudtasks.googleapis.com",           # Cloud Tasks
    # "workflows.googleapis.com",            # Workflows
    # "dns.googleapis.com",                  # Cloud DNS
    # "artifactregistry.googleapis.com",     # Artifact Registry (for build)
    # "containerscanning.googleapis.com",    # Container Scanning API
    # "composer.googleapis.com",             # Cloud Composer
    # "datastream.googleapis.com",           # Datastream (Change Data Capture)
    # "cloudiot.googleapis.com",             # Cloud IoT
    # "datacatalog.googleapis.com",          # Cloud Data Catalog
    # "datafusion.googleapis.com",           # Cloud Data Fusion
    # "healthcare.googleapis.com",           # Cloud Healthcare (bridge)
    # "lifesciences.googleapis.com",         # Cloud Life Sciences
    # "",  # Vertex AI
    # "",  # Data Labeling
  ])
}
resource "google_project_service" "base" {
  for_each = local.services
  service  = each.value
}
resource "google_service_account" "deploy" {
  account_id   = "deploy"
  display_name = "terraform-cicd"
}
locals {
  roles = toset([
    "roles/iam.serviceAccountAdmin", # サービス アカウント管理者
    "roles/iam.roleAdmin",           # ロールの管理者
    "roles/iam.securityAdmin",       # セキュリティ管理者
    "roles/iam.serviceAccountUser",  # サービス アカウント ユーザー
    "roles/storage.admin",           # ストレージ管理者
    # "roles/containerregistry.ServiceAgent", # Container Registry サービス エージェント
    # "roles/run.admin",                      # Cloud Run 管理者
    # "roles/cloudsql.admin",                 # Cloud SQL 管理者
    # "roles/bigquery.admin",                 # BigQuery 管理者
    # "roles/compute.admin",                  # Compute 管理者
    # "roles/datastore.owner",                # Cloud Datastore オーナー
    # "roles/oauthconfig.editor",             # OAuth Config 編集者(for oatuh brand client)
    # "roles/appengine.appAdmin",             # App Engine 管理者
    # "roles/appengine.appCreator",           # App Engine 作成者
    # "roles/pubsub.admin",                   # Pub/Sub 管理者
  ])
}
resource "google_project_iam_member" "deploy" {
  for_each = local.roles
  role     = each.value
  member   = "serviceAccount:${google_service_account.deploy.email}"
  # https://cloud.google.com/iam/docs/understanding-roles
}
