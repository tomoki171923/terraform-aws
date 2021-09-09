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

/*
    acm remote state
*/
data "terraform_remote_state" "acm" {
  backend = "s3"
  config = {
    bucket = "infra-develop-terraform"
    key    = "acm/ap-northeast-1/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

# es access policiy
data "template_file" "access_policiy_es" {
  template = file("${path.module}/policies/access_policiy_es.json")
  vars = {
    aws_region    = data.aws_region.current.name
    aws_account   = data.aws_caller_identity.current.account_id
    domain_name   = var.domain_name
    whitelist_ips = jsonencode(var.whitelist_ips)
  }
}