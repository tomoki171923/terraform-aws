data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "infra-develop-terraform"
    key    = "vpc/ap-northeast-1/terraform.tfstate"
    region = "ap-northeast-1"
  }
}