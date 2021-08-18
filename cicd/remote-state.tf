terraform {
  backend "gcs" {
    bucket = "marltake-practice-cicd-2"
    prefix = "develop"
  }
}
