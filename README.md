# learn-terraform-gcp
Terraform + GCP を実際に動かしてみる

# change log

## 2021-08-13
CI/CD workflowの設定 (/cicd)
- [GCSにtfstate](https://qiita.com/kawakawaryuryu/items/58d8afbb21155c2e9572)
  - Terraformの状態保存するBucketはTerraformの外で作るべき。だよね。とりあえず別世界線で[bucket作成だけ](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket)
  - [backends](https://www.terraform.io/docs/language/settings/backends/index.html)
    - backend.gcs.bucketは変数で指定できない?ので、remote-state.tfは直書き
- [GitHub Actions 実践入門 booth](https://miyajan.booth.pm/items/1865906)
  - [action-tflint](https://github.com/reviewdog/action-tflint)
  - [setup-terraform](https://github.com/hashicorp/setup-terraform) because hashicorp/terraform-github-actions repository is no longer active
    - https://www.terraform.io/docs/cli/config/config-file.html
  - pull_request event
    - https://docs.github.com/ja/actions/reference/workflow-syntax-for-github-actions
    - https://docs.github.com/ja/actions/reference/events-that-trigger-workflows#webhook-events
    - https://github.community/t/what-is-a-pull-request-synchronize-event/14784/3
    - 実験結果 https://github.com/marltake/learn-terraform-gcp/pull/5
      - branchesの制限しないと全branch対象
      - PRは source branch の workflow yaml を使用する
- [Terraform再入門2020](https://qiita.com/minamijoyo/items/3a7467f70d145ac03324)
  - [remote state を変えないで plan したい](https://qiita.com/minamijoyo/items/b4d70787556c83f289e7)
- app 写経 定期手にslack通知 [Qiita](https://qiita.com/donko_/items/6289bb31fecfce2cda79) [GitHub](https://github.com/donkomura/TerraformPractice)

## 2021-08-09
cert-botでhttps化 (/get-started)

## 2021-08-02
[Get Start](https://learn.hashicorp.com/collections/terraform/gcp-get-started) (/get-started)
- 初めの一歩。作ってから消すまで。
- 個別のパラメータだけ最初からterraform.tfvars に分離するよう変更した。 [use variables](https://learn.hashicorp.com/tutorials/terraform/google-cloud-platform-variables)
- localのコミット整理してpush
