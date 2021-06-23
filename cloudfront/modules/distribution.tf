# ********************************* #
# CloudFront
# ref: https://github.com/terraform-aws-modules/terraform-aws-cloudfront
#      https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution
#      https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate
# ********************************* #

locals {
  s3_origin_id   = "S3-${data.aws_s3_bucket.selected.id}"
  my_domain_name = "mydomain12345.net"
  acm_state      = data.terraform_remote_state.acm.outputs.acm
}

#️ ------------------------
# s3 distribution with cloudfront domain
#️ ------------------------
resource "aws_cloudfront_distribution" "s3_distribution" {
  comment             = "CloudFront Test by Terraform"
  enabled             = true
  is_ipv6_enabled     = true
  price_class         = "PriceClass_All"
  retain_on_delete    = false
  wait_for_deployment = false
  default_root_object = "index.html"
  #aliases = ["mysite.example.com", "yoursite.example.com"]

  origin {
    domain_name = data.aws_s3_bucket.selected.bucket_regional_domain_name
    origin_id   = local.s3_origin_id
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.s3_distribution.cloudfront_access_identity_path
    }
    /*
    custom_origin_config {
      http_port                = 80
      https_port               = 443
      origin_protocol_policy   = "match-viewer"
      origin_ssl_protocols     = ["TLSv1"]
      origin_keepalive_timeout = 60
      origin_read_timeout      = 60
    }
    */
  }

  default_cache_behavior {
    target_origin_id       = local.s3_origin_id
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true
    forwarded_values {
      query_string = true
      cookies {
        forward = "none"
      }
    }
  }

  ordered_cache_behavior {
    target_origin_id = local.s3_origin_id
    path_pattern     = "/img/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
      #restriction_type = "whitelist"
      #locations        = ["US", "CA", "GB", "DE"]
    }
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}


resource "aws_s3_bucket_policy" "s3_distribution" {
  bucket = data.aws_s3_bucket.selected.id
  policy = data.aws_iam_policy_document.s3_policy.json
}




#️ ------------------------
# s3 distribution with own domain
#️ ------------------------
resource "aws_cloudfront_distribution" "s3_distribution_with_own_domain" {
  comment             = "CloudFront Test by Terraform"
  enabled             = true
  is_ipv6_enabled     = true
  price_class         = "PriceClass_All"
  retain_on_delete    = false
  wait_for_deployment = false
  default_root_object = "index.html"
  aliases             = [local.my_domain_name]

  origin {
    domain_name = data.aws_s3_bucket.selected.bucket_regional_domain_name
    origin_id   = local.s3_origin_id
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.s3_distribution.cloudfront_access_identity_path
    }
    /*
    custom_origin_config {
      http_port                = 80
      https_port               = 443
      origin_protocol_policy   = "match-viewer"
      origin_ssl_protocols     = ["TLSv1"]
      origin_keepalive_timeout = 60
      origin_read_timeout      = 60
    }
    */
  }

  default_cache_behavior {
    target_origin_id       = local.s3_origin_id
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true
    forwarded_values {
      query_string = true
      cookies {
        forward = "none"
      }
    }
  }

  ordered_cache_behavior {
    target_origin_id = local.s3_origin_id
    path_pattern     = "/img/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn            = local.acm_state.certificate.arn
    minimum_protocol_version       = "TLSv1.2_2019"
    ssl_support_method             = "sni-only"
  }
}
