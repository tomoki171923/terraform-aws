output "zone" {
  value = {
    main    = aws_route53_zone.main
    sub-dev = aws_route53_zone.sub-dev
  }
}

output "record" {
  value = {
    dev-ns = aws_route53_record.dev-ns
  }
}
