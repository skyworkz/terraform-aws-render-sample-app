terraform {
  backend "s3" {
    bucket         = "terraform-backend-state-poc-render"
    key            = "just-a-poc/terraform.tfstate"
    dynamodb_table = "terraform-backend-state-poc-render"
    encrypt        = true
  }
}
