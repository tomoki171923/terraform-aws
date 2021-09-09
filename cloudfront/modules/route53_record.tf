# if create a record in sub domain zone.
# sub domain record (for sub domain zone)
resource "aws_route53_record" "sub_NS" {
  count   = 0
  zone_id = local.route53_state.zone.main.id
  name    = local.route53_state.zone.sub.name
  type    = "NS"
  ttl     = "30"
  records = local.route53_state.sub.name_servers
}

# if create a record in main domain zone.
# sub domain record (for main domain zone)
# e.g. cftest.mydomain12345.net
resource "aws_route53_record" "sub_A" {
  count   = local.is_main_domain == true ? 0 : 1
  zone_id = local.zone_id
  name    = local.alias
  type    = "A"
  alias {
    evaluate_target_health = true
    name                   = aws_cloudfront_distribution.s3_distribution_with_own_domain.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution_with_own_domain.hosted_zone_id
  }
}

# main domain record
resource "aws_route53_record" "main_A" {
  count   = local.is_main_domain == true ? 1 : 0
  zone_id = local.zone_id
  name    = local.domain_name
  type    = "A"
  alias {
    evaluate_target_health = true
    name                   = aws_cloudfront_distribution.s3_distribution_with_own_domain.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution_with_own_domain.hosted_zone_id
  }
}