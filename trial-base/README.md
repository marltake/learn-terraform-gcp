# setup
```zsh
export GOOGLE_APPLICATION_CREDENTIALS=$(echo secrets/*.json(:a))
terraform init && terraform fmt -check && terraform validate && terraform plan && terraform apply
```
