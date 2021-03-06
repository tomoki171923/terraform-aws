# ********************************* #
# EC2
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
# ********************************* #

locals {
  # Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type - ami-0404778e217f54308 (64 ビット x86) / ami-03195e1b4a3b0b993 (64 ビット Arm)
  #ami = "ami-03195e1b4a3b0b993" # Amazon Linux 2 arm
  ami = "ami-0ef5df6525f1522b3" # amzn2-ami-kernel-5.10-hvm-2.0.20211103.1-arm64-gp2 with ssm agent , cloudwatch agent and collectd.
}

resource "aws_instance" "open" {
  count                = 0
  ami                  = local.ami
  instance_type        = "t4g.nano"
  key_name             = "sample"
  iam_instance_profile = var.iam_instance_profile
  tags = {
    Name        = "${var.base_name}InstanceOpen"
    Environment = "dev"
    Terraform   = "true"
    SSM         = "true"
  }
}

resource "aws_instance" "this" {
  count                  = 1
  ami                    = local.ami
  instance_type          = "t4g.nano"
  key_name               = "sample"
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  iam_instance_profile   = var.iam_instance_profile
  user_data              = <<EOF
  #cloud-boothook
  #!/bin/bash

  echo "hello world" > /home/ec2-user/hello_world.txt

  EOF

  tags = {
    Name        = "${var.base_name}Instance"
    Environment = "dev"
    Terraform   = "true"
    SSM         = "true"
  }
}
