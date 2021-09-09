locals {
  route53_state = data.terraform_remote_state.route53.outputs.route53
  acm_state     = data.terraform_remote_state.acm.outputs.acm

  s3_origin_id = "S3-${data.aws_s3_bucket.selected.id}"
  domain_name  = local.route53_state.zone.main.name # mydomain12345.net
  zone_id      = local.route53_state.zone.main.id
  host_name    = "cftest"

  # use main domain or sub domain
  is_main_domain = false
  alias          = local.is_main_domain == true ? local.domain_name : "${local.host_name}.${local.domain_name}"
  acm_arn        = local.is_main_domain == true ? local.acm_state.certificate.main.arn : local.acm_state.certificate.sub.arn
}
