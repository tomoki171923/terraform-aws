# ********************************* #
# ECS
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster
#      https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
# ********************************* #

/*
resource "aws_ecs_cluster" "ecs-test-cluster" {
  name = local.ecs_cluster_name
}



resource "aws_route53_record" "ecs_load_balancer_record" {
  name = "*.${local.ecs_domain_name}"
  type = "A"
  zone_id = data.aws_route53_zone.ecs_domain.zone_id

  alias {
    evaluate_target_health  = false
    name                    = aws_alb.ecs_cluster_alb.dns_name
    zone_id                 = aws_alb.ecs_cluster_alb.zone_id
  }
}
*/
