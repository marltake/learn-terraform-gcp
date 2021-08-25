terraform {
  backend "gcs" {
    bucket = "trial-base-mtk-state" # "${var.project}-state"
    prefix = "develop"
  }
}
