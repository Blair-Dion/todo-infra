provider "aws" {
  region  = "ap-northeast-2"
}

resource "aws_s3_bucket" "tfstate" {
  bucket = "bladi-todo-apne2-tfstate"

  versioning {
    enabled = true
  }
}

resource "aws_dynamodb_table" "todo_tfstate_lock" {
  name         = "bladi-todo-tfstate-lock"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}

