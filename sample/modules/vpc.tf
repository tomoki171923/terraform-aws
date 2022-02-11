# ********************************* #
# VPC
# ref: https://github.com/terraform-aws-modules/terraform-aws-vpc/blob/master/examples/complete-vpc/main.tf
# ********************************* #

module "vpc" {
  # remote module
  source     = "terraform-aws-modules/vpc/aws"
  version    = "3.12.0"
  create_vpc = true
  name       = "${var.base_name}-vpc"
  cidr       = "10.101.0.0/16"

  azs              = ["ap-northeast-1a", "ap-northeast-1c"]
  private_subnets  = ["10.101.1.0/24", "10.101.2.0/24"]
  public_subnets   = ["10.101.11.0/24", "10.101.12.0/24"]
  database_subnets = ["10.101.21.0/24", "10.101.22.0/24"]
  enable_ipv6      = false

  # dns
  enable_dns_hostnames = true
  enable_dns_support   = true

  # nat gateway
  enable_nat_gateway     = var.nat_gateway
  single_nat_gateway     = var.nat_gateway
  one_nat_gateway_per_az = false

  # Default security group - ingress/egress rules cleared to deny all
  manage_default_security_group  = true
  default_security_group_ingress = []
  default_security_group_egress  = []

  # tag
  vpc_tags = {
    Name        = "${var.base_name}-vpc"
    Terraform   = "true"
    Environment = "dev"
  }
  public_subnet_tags = {
    Name        = "${var.base_name}-public-subnet"
    Terraform   = "true"
    Environment = "dev"
  }
  private_subnet_tags = {
    Name        = "${var.base_name}-private-subnet"
    Terraform   = "true"
    Environment = "dev"
  }
  database_subnet_tags = {
    Name        = "${var.base_name}-database-subnet"
    Terraform   = "true"
    Environment = "dev"
  }
}

# These subnets are exclusively for vpc endpoints.
resource "aws_subnet" "vpc_endpoint_a" {
  vpc_id            = module.vpc.vpc_id
  cidr_block        = "10.101.31.0/24"
  availability_zone = "ap-northeast-1a"
  tags = {
    Name        = "${var.base_name}-vpc-endpoint-a-subnet"
    Terraform   = "true"
    Environment = "dev"
  }
}
resource "aws_subnet" "vpc_endpoint_c" {
  vpc_id            = module.vpc.vpc_id
  cidr_block        = "10.101.32.0/24"
  availability_zone = "ap-northeast-1c"
  tags = {
    Name        = "${var.base_name}-vpc-endpoint-c-subnet"
    Terraform   = "true"
    Environment = "dev"
  }
}
