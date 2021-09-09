output "zone" {
  value = {
    main = aws_route53_zone.main
    sub  = aws_route53_zone.sub
  }
}
