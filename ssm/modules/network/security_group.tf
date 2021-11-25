# ********************************* #
# security group
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
# ********************************* #

resource "aws_security_group" "public" {
  name        = "${var.vpc_name}-public-sg"
  description = "Allow all inbound traffic"
  vpc_id      = module.vpc.vpc_id
  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = "${var.vpc_name}-public-sg"
    Terraform   = "true"
    Environment = "dev"
  }
}


resource "aws_security_group" "ssm" {
  name        = "${var.vpc_name}-ssm-sg"
  description = "Allow https inbound traffic from vpc subnets"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSL/TLS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  tags = {
    Name        = "${var.vpc_name}-ssm-sg"
    Terraform   = "true"
    Environment = "dev"
  }
}
