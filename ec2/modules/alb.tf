# ********************************* #
# ALB
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
#      https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener
#      https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule
#      https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group
# ********************************* #


# alb
resource "aws_lb" "alb" {
  name               = "sample-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = data.aws_security_groups.sample-web-sg.ids
  subnets            = data.aws_subnet_ids.sample-public-subnet.ids
  ip_address_type = "ipv4"
  tags = {
    Name        = "sample-single"
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Not found path"
      status_code  = "503"
    }
  }
}

resource "aws_lb_listener_rule" "lb_listener_rule" {
  listener_arn = aws_lb_listener.lb_listener.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }

  condition {
    path_pattern {
      values = ["/static/*"]
    }
  }

  condition {
    host_header {
      values = ["example.com", "*.amazonaws.com"]
    }
  }
}

# target group
resource "aws_lb_target_group" "tg" {
  name     = "sample-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.sample.id
  health_check{
      enabled = "true"
      healthy_threshold = "5"
      interval = "30"
      matcher = "200"
      path = "/api/v1/healthcheck"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = "29"
      unhealthy_threshold = "2"
  }
}