# backend

terraform {
  required_version = ">= 0.14"

  backend "s3" {
    bucket  = "infra-production-terraform"
    key     = "lambda/ap-northeast-1/terraform.tfstate"
    region  = "ap-northeast-1"
    encrypt = true
  }
}