# backend

terraform {
  required_version = ">= 0.15"

  backend "s3" {
    bucket  = "infra-develop-terraform"
    key     = "sample/ap-northeast-1/terraform.tfstate"
    region  = "ap-northeast-1"
    encrypt = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.70"
    }
  }
}
