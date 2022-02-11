# launch configuration
resource "aws_launch_configuration" "this" {
  name_prefix          = "${var.base_name}-clb-instance"
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
  name                      = "${var.base_name}-clb-asg"
  launch_configuration      = aws_launch_configuration.this.name
  max_size                  = 4
  min_size                  = 2
  desired_capacity          = 2
  health_check_type         = "EC2"
  load_balancers            = [aws_elb.this.name]
  vpc_zone_identifier       = var.subnet_ids_computing
  health_check_grace_period = 300
  lifecycle {
    create_before_destroy = true
  }
  tags = concat(
    [
      {
        "key"                 = "Name"
        "value"               = "${var.base_name}-clb-instance"
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
