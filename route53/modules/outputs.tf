output "zone" {
  value = {
    main    = aws_route53_zone.main
    sub-dev = aws_route53_zone.sub-dev
  }
}

output "record" {
  value = {
    dev-ns          = aws_route53_record.dev-ns
    main-a          = aws_route53_record.main-a
    cert_validation = aws_route53_record.cert_validation
  }
}

output "certificate_validation" {
  value = aws_acm_certificate_validation.domain_certificate_validation
}