# ********************************* #
# Route53 Zone
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone
# ********************************* #

# main domain zone
resource "aws_route53_zone" "main" {
  name = var.domain_name
  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}

# sub domain zone
resource "aws_route53_zone" "sub" {
  count = 0
  name  = "sub.${var.domain_name}"
  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}