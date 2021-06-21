
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