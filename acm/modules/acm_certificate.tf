# ********************************* #
# ACM
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate
# ********************************* #

resource "aws_acm_certificate" "cert" {
  domain_name       = "mydomain12345.net"
  validation_method = "DNS"
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}