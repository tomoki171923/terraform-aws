
/*
    aws_cloudfront_distribution
*/
data "terraform_remote_state" "cloudfront" {
  backend = "s3"
  config = {
    bucket = "infra-develop-terraform"
    key    = "cloudfront/ap-northeast-1/terraform.tfstate"
    region = "ap-northeast-1"
  }
}


/*
    aws_acm_certificate
*/
data "terraform_remote_state" "acm" {
  backend = "s3"
  config = {
    bucket = "infra-develop-terraform"
    key    = "acm/us-east-1/terraform.tfstate"
    region = "ap-northeast-1"
  }
}