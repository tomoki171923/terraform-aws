output "domain" {
  value = aws_elasticsearch_domain.sample
}

output "route53_record" {
  value = {
    sub_CNAME = aws_route53_record.sub_CNAME
  }
}