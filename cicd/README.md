# logs for setup

## just make bucket for terraform state
```
shigenori.otake@GM10337 cicd % terraform show
# google_storage_bucket.terraform-state-store:
resource "google_storage_bucket" "terraform-state-store" {
    bucket_policy_only = false
    force_destroy      = false
    id                 = "marltake-practice-cicd"
    location           = "US-CENTRAL1"
    name               = "marltake-practice-cicd"
    project            = "practice-cicd-322801"
    requester_pays     = false
    self_link          = "https://www.googleapis.com/storage/v1/b/marltake-practice-cicd"
    storage_class      = "REGIONAL"
    url                = "gs://marltake-practice-cicd"

    lifecycle_rule {
        action {
            type = "Delete"
        }

        condition {
            age                   = 0
            is_live               = false
            matches_storage_class = []
            num_newer_versions    = 5
            with_state            = "ANY"
        }
    }

    versioning {
        enabled = true
    }
}
```

## remote init

gcsにstateを移動したら, init, plan　は常にGOOGLE_BACKEND_CREDENTIALSが必要。それはそうか。

localのstateはcopyしない。state用bucketを作成した時の情報で、以後管理から外すため。

```
shigenori.otake@GM10337 cicd % export GOOGLE_CREDENTIALS=secrets/<SECRET_JSON>
shigenori.otake@GM10337 cicd % terraform init

Initializing the backend...
Do you want to copy existing state to the new backend?
  Pre-existing state was found while migrating the previous "local" backend to the
  newly configured "gcs" backend. No existing state was found in the newly
  configured "gcs" backend. Do you want to copy this state to the new "gcs"
  backend? Enter "yes" to copy and "no" to start with an empty state.

  Enter a value: no


Successfully configured the backend "gcs"! Terraform will automatically
use this backend unless the backend configuration changes.

Initializing provider plugins...
- Reusing previous version of hashicorp/google from the dependency lock file
- Using previously-installed hashicorp/google v3.5.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```
