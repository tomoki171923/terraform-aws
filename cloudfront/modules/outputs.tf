output "distribution" {
  value = {
    s3_distribution                 = aws_cloudfront_distribution.s3_distribution
    s3_distribution_with_own_domain = aws_cloudfront_distribution.s3_distribution_with_own_domain
  }
}

output "origin_access_identity" {
  value = aws_cloudfront_origin_access_identity.s3_distribution
}

output "s3_bucket_policy" {
  value = aws_s3_bucket_policy.s3_distribution
}

output "route53_record" {
  value = {
    sub_NS = aws_route53_record.sub_NS
    sub_A  = aws_route53_record.sub_A
    main_A = aws_route53_record.main_A

  }
}