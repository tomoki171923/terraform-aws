# ********************************* #
# EC2
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
#      https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_configuration
# ********************************* #


resource "aws_instance" "sample-single" {
  count                  = 1
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t4g.micro"
  key_name               = "sample"
  subnet_id              = tolist(data.aws_subnet_ids.sample-public-subnet.ids)[count.index]
  vpc_security_group_ids = data.aws_security_groups.sample-public-sg.ids
  #iam_instance_profile = "" # TODO 
  #user_data # TODO

  tags = {
    Name = "sample-single"
    Terraform   = "true"
    Environment = "dev"
  }
}