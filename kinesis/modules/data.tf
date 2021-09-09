data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

data "terraform_remote_state" "es" {
  backend = "s3"
  config = {
    bucket = "infra-develop-terraform"
    key    = "es/amazon-es/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

data "terraform_remote_state" "s3" {
  backend = "s3"
  config = {
    bucket = "infra-develop-terraform"
    key    = "s3/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

# firehose policiy
data "template_file" "policy" {
  template = file("${path.module}/policies/KinesisFirehoseServicePolicy.json")
  vars = {
    aws_region     = data.aws_region.current.name
    aws_account    = data.aws_caller_identity.current.account_id
    es_domain_name = local.es_state.domain.domain_name
    es_arn         = local.es_state.domain.arn
    s3_bucket_arn  = local.s3_state.bucket.tf-test-private-bucket.s3_bucket_arn
  }
}
