# if custum domain setting (e.g. es.mydomain12345.net)

resource "aws_route53_record" "sub_CNAME" {
  zone_id = local.route53_state.zone.main.id
  name    = "es"
  type    = "CNAME"
  ttl     = 30
  records = [aws_elasticsearch_domain.sample.endpoint]
}

