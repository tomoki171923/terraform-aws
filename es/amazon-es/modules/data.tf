data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

/*
    route53 remote state
*/
data "terraform_remote_state" "route53" {
  backend = "s3"
  config = {
    bucket = "infra-develop-terraform"
    key    = "route53/terraform.tfstate"
    region = "ap-northeast-1"
  }
}