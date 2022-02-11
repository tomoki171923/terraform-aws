# ********************************* #
# ALB
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
#      https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener
#      https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule
# ********************************* #

# clb
resource "aws_elb" "this" {
  name            = "${var.base_name}-clb"
  subnets         = var.subnet_ids_lb
  security_groups = var.security_group_ids_lb

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  listener {
    instance_port      = 80
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = data.aws_acm_certificate.this.arn
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  # instances                   = [aws_instance.foo.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "${var.base_name}-clb"
  }
}

data "aws_acm_certificate" "this" {
  domain   = "*.mydomain12345.net"
  statuses = ["ISSUED"]
}
