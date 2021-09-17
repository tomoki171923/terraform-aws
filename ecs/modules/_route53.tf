resource "aws_route53_record" "a_record" {
  name = "ecs.${local.route53_state.zone.main.name}"
  zone_id = local.route53_state.zone.main.id
  type = "A"

  alias {
    evaluate_target_health  = false
    name                    = aws_alb.ecs_cluster.dns_name
    zone_id                 = aws_alb.ecs_cluster.zone_id
  }
}
