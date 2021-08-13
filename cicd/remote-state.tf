terraform {
  backend "gcs" {
    bucket = "marltake-practice-cicd"
    prefix = "develop"
  }
}
