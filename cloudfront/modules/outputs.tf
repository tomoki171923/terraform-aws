output "distribution" {
  value = aws_cloudfront_distribution.s3_distribution
}

output "origin_access_identity" {
  value = aws_cloudfront_origin_access_identity.s3_distribution
}

output "s3_bucket_policy" {
  value = aws_s3_bucket_policy.s3_distribution
}