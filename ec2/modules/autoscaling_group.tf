# ********************************* #
# EC2 Autoscaling Group
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_configuration
#      https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_policy
# ********************************* #


resource "aws_launch_configuration" "sample-cluster" {
  name_prefix   = "sample-cluster-"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t4g.micro"
  #iam_instance_profile = "" # TODO 
  security_groups = data.aws_security_groups.sample-private-sg.ids
  key_name        = "sample"
  root_block_device {
    volume_size = 8
  }
  lifecycle {
    create_before_destroy = true
  }
  user_data = <<EOF
  #cloud-boothook
  #!/bin/bash

  echo "hello world" > /home/ubuntu/hello_world.txt

  EOF

}

resource "aws_autoscaling_group" "asg" {
  name                      = "sample-asg"
  launch_configuration      = aws_launch_configuration.sample-cluster.name
  max_size                  = 3
  min_size                  = 2
  desired_capacity          = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true
  vpc_zone_identifier       = data.aws_subnet_ids.sample-private-subnet.ids
  lifecycle {
    create_before_destroy = true
  }
  tags = concat(
    [
      {
        "key"                 = "Name"
        "value"               = "sample-cluster"
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
      }
    ]
  )
}

resource "aws_autoscaling_policy" "memory-hot" {
  name                   = "sample-cluster-memory-hot"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 120
  autoscaling_group_name = aws_autoscaling_group.asg.name
}
