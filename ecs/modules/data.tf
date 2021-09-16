data "aws_region" "current" {}

# acm remote state
data "terraform_remote_state" "acm" {
  backend = "s3"
  config = {
    bucket = "infra-develop-terraform"
    key    = "acm/ap-northeast-1/terraform.tfstate"
    region = "ap-northeast-1"
  }
}