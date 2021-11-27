# ********************************* #
# security group
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
# ********************************* #

resource "aws_security_group" "public" {
  name        = "${var.base_name}-public-sg"
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
    Name        = "${var.base_name}-public-sg"
    Terraform   = "true"
    Environment = "dev"
  }
}

# ssm permission to vpc endpoints.
resource "aws_security_group" "ssm2vpcep" {
  name        = "${var.base_name}-ssm2vpcep-sg"
  description = "Allow https outbound traffic to vpc endpoints"
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
    Name        = "${var.base_name}-ssm2vpcep-sg"
    Terraform   = "true"
    Environment = "dev"
  }
}

# ssm permission to ec2 instances.
resource "aws_security_group" "ssm2ec2" {
  name        = "${var.base_name}-ssm2ec2-sg"
  description = "Allow https inbound traffic from vpc endpoints"
  vpc_id      = module.vpc.vpc_id

  egress {
    description = "SSL/TLS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  tags = {
    Name        = "${var.base_name}-ssm2ec2-sg"
    Terraform   = "true"
    Environment = "dev"
  }
}
