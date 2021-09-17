#      https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb

resource "aws_alb" "ecs_cluster" {
  name            = "${local.ecs_cluster_name}-alb"
  internal        = false
  security_groups = [aws_security_group.ecs_alb.id]
  subnets         = [aws_subnet.public-a.id, aws_subnet.public-c.id]

  tags = {
    Name        = "${local.ecs_cluster_name}-alb"
    Terraform   = "true"
    Environment = "dev"
  }
}


resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_alb.ecs_cluster.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      host        = "#{host}"
      path        = "/#{path}"
      port        = "443"
      protocol    = "HTTPS"
      query       = "#{query}"
      status_code = "HTTP_301"
    }
  }
  tags = {
    Name        = "${local.ecs_cluster_name}-alb-listener-http"
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_alb_listener" "https" {
  load_balancer_arn = aws_alb.ecs_cluster.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = local.acm_state.certificate.sub.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.tg.arn
  }

  depends_on = [aws_alb_target_group.tg]
  tags = {
    Name        = "${local.ecs_cluster_name}-alb-listener-https"
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_alb_listener_rule" "https" {
  listener_arn = aws_alb_listener.https.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.tg.arn
  }

  condition {
    host_header {
      values = [local.domain_name]
    }
  }
}


resource "aws_alb_target_group" "tg" {
  name     = "${local.ecs_cluster_name}-tg"
  port     = local.container_port
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = "60"
    timeout             = "30"
    unhealthy_threshold = "3"
    healthy_threshold   = "3"
  }

  tags = {
    Name        = "${local.ecs_cluster_name}-tg"
    Terraform   = "true"
    Environment = "dev"
  }
}
