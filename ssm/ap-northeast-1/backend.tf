# backend

terraform {
  required_version = ">= 0.15"
  backend "s3" {
    bucket  = "infra-develop-terraform"
    key     = "ssm/ap-northeast-1/terraform.tfstate"
    region  = "ap-northeast-1"
    encrypt = true
  }
}
