
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