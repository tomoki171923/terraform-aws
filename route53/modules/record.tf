# ********************************* #
# CloudFront Record
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record
# ********************************* #


resource "aws_route53_record" "dev-ns" {
  zone_id = aws_route53_zone.main.zone_id
  name    = aws_route53_zone.sub-dev.name
  type    = "NS"
  ttl     = "30"
  records = aws_route53_zone.sub-dev.name_servers
}