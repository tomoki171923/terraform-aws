# ********************************* #
# CloudFront Origin Access Identity
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_identity
# ********************************* #

resource "aws_cloudfront_origin_access_identity" "s3_distribution" {
  comment = "s3 distribution"
}