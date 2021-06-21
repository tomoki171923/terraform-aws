# ********************************* #
# CloudFront Record
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record
# ********************************* #

locals {
  cloudfront_state = data.terraform_remote_state.cloudfront.outputs.cloudfront
}


resource "aws_route53_record" "dev-ns" {
  zone_id = aws_route53_zone.main.zone_id
  name    = aws_route53_zone.sub-dev.name
  type    = "NS"
  ttl     = "30"
  records = aws_route53_zone.sub-dev.name_servers
}

resource "aws_route53_record" "main-a" {
  zone_id = aws_route53_zone.main.zone_id
  name    = aws_route53_zone.main.name
  type    = "A"
  alias {
    evaluate_target_health = true
    name                   = local.cloudfront_state.distribution.domain_name
    zone_id                = local.cloudfront_state.distribution.hosted_zone_id
  }
}
