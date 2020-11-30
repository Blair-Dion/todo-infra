# Todo Project Infra

내가 짠 코드도 리뷰하자!

## Tech Stack

- MySQL(AWS RDS)
- CI/CD(Github Actions)
- Terraform
- AWS VPC
- AWS EC2
- NginX

## API Document

작성예정

## How To Run

```shell
cd init
mv backend.tf backend
terraform init
terraform plan
terraform apply

yes

mv backend backend.tf
terraform init
rm -f terraform.tfstate*

cd ../vpc
terraform init
terraform plan
terraform apply

yes
```
