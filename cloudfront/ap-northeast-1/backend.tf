# backend

terraform {
  required_version = ">= 0.14"
  backend "s3" {
    bucket  = "infra-develop-terraform"
    key     = "cloudfront/ap-northeast-1/terraform.tfstate"
    region  = "ap-northeast-1"
    encrypt = true
  }
}