# ********************************* #
# CloudFront Record
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record
# ********************************* #

locals {
  cloudfront_state = data.terraform_remote_state.cloudfront.outputs.cloudfront
  acm_state        = data.terraform_remote_state.acm.outputs.acm.certificate.main
}

/*
  sub domain NS record
*/
resource "aws_route53_record" "dev-ns" {
  zone_id = aws_route53_zone.main.zone_id
  name    = aws_route53_zone.sub-dev.name
  type    = "NS"
  ttl     = "30"
  records = aws_route53_zone.sub-dev.name_servers
}

/*
  main domain A record to cloudfront
*/
resource "aws_route53_record" "main-a" {
  zone_id = aws_route53_zone.main.zone_id
  name    = aws_route53_zone.main.name
  type    = "A"
  alias {
    evaluate_target_health = true
    name                   = local.cloudfront_state.distribution.s3_distribution.domain_name
    zone_id                = local.cloudfront_state.distribution.s3_distribution.hosted_zone_id
  }
}


/*
    ssl certificate
*/
resource "aws_route53_record" "cert_validation" {
  for_each = {
    for domain in local.acm_state.domain_validation_options : domain.domain_name => {
      name   = domain.resource_record_name
      record = domain.resource_record_value
      type   = domain.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.main.zone_id
}

resource "aws_acm_certificate_validation" "domain_certificate_validation" {
  certificate_arn         = local.acm_state.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}
