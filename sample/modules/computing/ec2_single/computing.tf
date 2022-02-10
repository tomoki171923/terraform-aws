resource "aws_instance" "this" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  key_name               = "sample"
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  iam_instance_profile   = var.instance_profile
  user_data              = <<EOF
  #cloud-boothook
  #!/bin/bash

  echo "hello world" > /home/ec2-user/hello_world.txt

  EOF

  tags = {
    Name        = "${var.base_name}-single-instance"
    Environment = "dev"
    Terraform   = "true"
    SSM         = "true"
  }
}
