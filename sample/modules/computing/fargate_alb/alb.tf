# ********************************* #
# ALB
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
#      https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener
#      https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule
# ********************************* #


# alb
resource "aws_lb" "this" {
  name               = "${var.base_name}-alb-fargate"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_group_ids_lb
  subnets            = var.subnet_ids_lb
  ip_address_type    = "ipv4"
  tags = {
    Name        = "${var.base_name}-alb-fargate"
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
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

/*
# address SSL.
data "aws_acm_certificate" "this" {
  domain   = "*.mydomain12345.net"
  statuses = ["ISSUED"]
}

# attach certificate to alb
resource "aws_lb_listener_certificate" "this" {
  listener_arn    = aws_lb_listener.this.arn
  certificate_arn = aws_acm_certificate.this.arn
}

# redirect to 443 from 80
resource "aws_lb_listener_rule" "redirect_https" {
  listener_arn = aws_lb_listener.this.arn
  priority     = 1

  action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }
}
*/

resource "aws_lb_listener_rule" "forward_tg" {
  listener_arn = aws_lb_listener.this.arn
  priority     = 2

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }

  # restrict host header.
  # condition {
  #   host_header {
  #     values = ["*.amazonaws.com"]
  #   }
  # }
}
