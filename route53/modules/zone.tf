# ********************************* #
# Route53 Zone
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone
# ********************************* #


resource "aws_route53_zone" "main" {
  name = var.domain_name
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

# sub domain
resource "aws_route53_zone" "sub-dev" {
  name = "dev.${var.domain_name}"
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}