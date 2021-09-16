# backend

terraform {
  required_version = ">= 0.14"
  backend "s3" {
    bucket  = "infra-develop-terraform"
    key     = "es/amazon-es/terraform.tfstate"
    region  = "ap-northeast-1"
    encrypt = true

  }
}