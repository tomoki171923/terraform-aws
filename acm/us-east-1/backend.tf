# backend

terraform {
  required_version = ">= 0.14"
  backend "s3" {
    bucket  = "infra-develop-terraform"
    key     = "acm/us-east-1/terraform.tfstate"
    region  = "ap-northeast-1"
    encrypt = true
  }
}