terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.21.0, < 6.0"
    }

    render = {
      source  = "jackall3n/render"
      version = "1.1.1"
    }
  }
}
