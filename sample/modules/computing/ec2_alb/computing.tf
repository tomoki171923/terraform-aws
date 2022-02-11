# launch configuration
resource "aws_launch_configuration" "this" {
  name_prefix          = "${var.base_name}-alb-instance"
  image_id             = var.instance_ami
  instance_type        = var.instance_type
  iam_instance_profile = var.instance_profile
  security_groups      = var.security_group_ids_computing
  key_name             = "sample"
  lifecycle {
    create_before_destroy = true
  }
}

# autoscaling group
resource "aws_autoscaling_group" "this" {
  name                 = "${var.base_name}-alb-asg"
  launch_configuration = aws_launch_configuration.this.name
  max_size             = 4
  min_size             = 2
  desired_capacity     = 2
  health_check_type    = "ELB"
  target_group_arns    = [aws_lb_target_group.this.arn]
  vpc_zone_identifier  = var.subnet_ids_computing
  lifecycle {
    create_before_destroy = true
  }
  tags = concat(
    [
      {
        "key"                 = "Name"
        "value"               = "${var.base_name}-alb-instance"
        "propagate_at_launch" = true
      },
      {
        "key"                 = "Terraform"
        "value"               = "true"
        "propagate_at_launch" = true
      },
      {
        "key"                 = "Environment"
        "value"               = "dev"
        "propagate_at_launch" = true
      },
      {
        "key"                 = "SSM"
        "value"               = "true"
        "propagate_at_launch" = true
      }
    ]
  )
}

# target group
resource "aws_lb_target_group" "this" {
  # AWSロードバランサにおけるターゲットグループがリスナーとしてロードバランサに登録されていると、 一度リスナー登録を削除しない限りターゲットグループを削除できない。
  # そのためcreate_before_destroyをtureにして、再作成時にdestroy前の名前と被らないようにnameをuniqにしている。
  name        = "${var.base_name}-alb-tg-${substr(uuid(), 0, 4)}"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id
  health_check {
    enabled             = true
    healthy_threshold   = 5
    interval            = 30
    matcher             = 200
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 29
    unhealthy_threshold = 2
  }
  lifecycle {
    create_before_destroy = true
  }
}
