# learn-terraform-gcp
Terraform + GCP を実際に動かしてみる

# change log

## 2021-08-13
CI/CD workflowの設定 (/cicd)
- [GCSにtfstate](https://qiita.com/kawakawaryuryu/items/58d8afbb21155c2e9572)
  - [backends](https://www.terraform.io/docs/language/settings/backends/index.html)
- [GitHub Actions 実践入門 booth](https://miyajan.booth.pm/items/1865906)
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
