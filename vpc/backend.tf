terraform {
  backend "s3" {
    bucket = "bladi-todo-apne2-tfstate"
    key = "todo-infra/vpc/terraform.tfstate"
    region = "ap-northeast-2"
    encrypt = true
    dynamodb_table = "bladi-todo-tfstate-lock"
  }
}
