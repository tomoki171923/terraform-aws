
/*
    S3 Bucket Data
*/
data "aws_s3_bucket" "selected" {
  bucket = "tf-test-hosting-cloudfront-bucket"
}



/*
  s3 bucket policy 
*/
data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${data.aws_s3_bucket.selected.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.s3_distribution.iam_arn]
    }
  }
}


# acm remote state
# To use an ACM certificate with Amazon CloudFront, you must request or import the certificate in the US East (N. Virginia) region. 
# https://docs.aws.amazon.com/acm/latest/userguide/acm-regions.html
data "terraform_remote_state" "acm" {
  backend = "s3"
  config = {
    bucket = "infra-develop-terraform"
    key    = "acm/us-east-1/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

# route53 remote state
data "terraform_remote_state" "route53" {
  backend = "s3"
  config = {
    bucket = "infra-develop-terraform"
    key    = "route53/terraform.tfstate"
    region = "ap-northeast-1"
  }
}