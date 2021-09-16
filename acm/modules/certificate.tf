# ********************************* #
# ACM
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate
# ********************************* #

resource "aws_acm_certificate" "main" {
  domain_name       = local.main_domain_name
  validation_method = "DNS"
  tags = {
    Name        = "Certificate-${local.main_domain_name}"
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_acm_certificate" "sub" {
  domain_name       = "*.${local.main_domain_name}"
  validation_method = "DNS"
  tags = {
    Name        = "Certificate-${local.main_domain_name}-sub"
    Terraform   = "true"
    Environment = "dev"
  }
}

