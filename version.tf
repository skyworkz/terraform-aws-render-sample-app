terraform {
  required_version = ">= 1.6, < 2.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.21.0"
    }

    render = {
      source  = "jackall3n/render"
      version = "1.1.1"
    }
  }
}
