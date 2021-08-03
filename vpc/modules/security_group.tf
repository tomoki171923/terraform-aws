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

resource "aws_security_group" "private" {
  name        = "${var.vpc_name}-private-sg"
  description = "Allow ssh inbound traffic from public subnet"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "ssh from public subnet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = module.vpc.public_subnets_cidr_blocks
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  ingress {
    description     = "rails"
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.web.id]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = "${var.vpc_name}-private-sg"
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_security_group" "web" {
  name        = "${var.vpc_name}-web-sg"
  description = "Allow http/https inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSL/TLS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = "${var.vpc_name}-web-sg"
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_security_group" "redis" {
  name        = "${var.vpc_name}-redis-sg"
  description = "Allow redis inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "redis"
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = "${var.vpc_name}-redis-sg"
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_security_group" "postgres" {
  name        = "${var.vpc_name}-postgres-sg"
  description = "Allow postgres inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "postgres"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = "${var.vpc_name}-postgres-sg"
    Terraform   = "true"
    Environment = "dev"
  }
}