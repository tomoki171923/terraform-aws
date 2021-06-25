# ********************************* #
# ECS
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster
#      https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
# ********************************* #

resource "aws_ecs_cluster" "ecs-test-cluster" {
  name = local.ecs_cluster_name
}

resource "aws_alb" "ecs_cluster_alb" {
  name            = "${local.ecs_cluster_name}-alb"
  internal        = false
  security_groups = [aws_security_group.ecs_alb_security_group.id]
  # subnets         = [split(",", join(",", data.terraform_remote_state.infrastructure.outputs.public_subnets))]
  subnets = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id]

  tags = {
    Name        = "${local.ecs_cluster_name}-alb"
    Terraform   = "true"
    Environment = "dev"
  }
}


resource "aws_alb_listener" "ecs_alb_https_listener" {
  load_balancer_arn = aws_alb.ecs_cluster_alb.arn
  #port              = 443
  #protocol          = "HTTPS"
  #ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  #certificate_arn   = aws_acm_certificate.ecs_domain_certificate.arn
  port     = 80
  protocol = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.ecs_default_target_group.arn
  }

  depends_on = [aws_alb_target_group.ecs_default_target_group]
  tags = {
    Name        = "${local.ecs_cluster_name}-alb-listener"
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_alb_target_group" "ecs_default_target_group" {
  name     = "${local.ecs_cluster_name}-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.ecs-test-vpc.id
  tags = {
    Name        = "${local.ecs_cluster_name}-tg"
    Terraform   = "true"
    Environment = "dev"
  }
}

/*
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
