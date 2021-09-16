/*
  for ecs cluster
*/

resource "aws_security_group" "ecs_cluster" {
  name        = "${local.ecs_cluster_name}-sg"
  description = "Security group for ECS to communicate in and out"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 32768
    protocol    = "TCP"
    to_port     = 65535
    cidr_blocks = [aws_vpc.vpc.cidr_block]
  }

  ingress {
    from_port   = 22
    protocol    = "TCP"
    to_port     = 22
    cidr_blocks = [local.internet_cidr_block]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = [local.internet_cidr_block]
  }

  tags = {
    Name        = "${local.ecs_cluster_name}-sg"
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_security_group" "ecs_alb" {
  name        = "${local.ecs_cluster_name}-sg-alb"
  description = "Security group for ALB to traffic for ECS cluster"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 443
    protocol    = "TCP"
    to_port     = 443
    cidr_blocks = [local.internet_cidr_block]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = [local.internet_cidr_block]
  }

  tags = {
    Name        = "${local.ecs_cluster_name}-sg-alb"
    Terraform   = "true"
    Environment = "dev"
  }
}



/*
  for ecs service
*/

resource "aws_security_group" "ecs_service" {
  name        = "${local.ecs_service_name}-sg"
  description = "Security group for springbootapp to communicate in and out"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 8080
    protocol    = "TCP"
    to_port     = 8080
    cidr_blocks = [aws_vpc.vpc.cidr_block]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.ecs_service_name}-sg"
  }
}