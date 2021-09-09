
output "certificate" {
  value = {
    main = aws_acm_certificate.main
    sub  = aws_acm_certificate.sub
  }
}