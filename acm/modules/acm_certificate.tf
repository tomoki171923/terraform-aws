# ********************************* #
# ACM
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate
# ********************************* #

locals {
  domain_name = "mydomain12345.net"
}

resource "aws_acm_certificate" "cert" {
  domain_name       = local.domain_name
  validation_method = "DNS"
  tags = {
    Name        = "Certificate-${local.domain_name}"
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_acm_certificate" "cert-sub" {
  domain_name       = "*.${local.domain_name}"
  validation_method = "DNS"
  tags = {
    Name        = "Certificate-${local.domain_name}-sub"
    Terraform   = "true"
    Environment = "dev"
  }
}
