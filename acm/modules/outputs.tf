
output "certificate" {
  value = {
    main = aws_acm_certificate.cert
    sub  = aws_acm_certificate.cert-sub
  }
}