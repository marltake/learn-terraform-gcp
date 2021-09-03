terraform {
  backend "gcs" {
    bucket = "trial-cicd-a-state"
    prefix = "develop"
  }
}
