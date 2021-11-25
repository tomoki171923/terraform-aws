# ********************************* #
# VPC
# ref: https://github.com/terraform-aws-modules/terraform-aws-vpc/blob/master/examples/complete-vpc/main.tf
# ********************************* #

module "vpc" {
  # remote module
  source     = "terraform-aws-modules/vpc/aws"
  create_vpc = true
  name       = "${var.vpc_name}-vpc"
  cidr       = "10.101.0.0/16"

  azs             = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
  private_subnets = ["10.101.1.0/24", "10.101.2.0/24"]
  public_subnets  = ["10.101.11.0/24", "10.101.12.0/24"]
  enable_ipv6     = false

  # dns
  enable_dns_hostnames = true
  enable_dns_support   = true

  # nat gateway
  enable_nat_gateway     = false
  single_nat_gateway     = false
  one_nat_gateway_per_az = false

  # s3 endpoint
  #enable_s3_endpoint = true

  # dynamodb endpoint
  #enable_dynamodb_endpoint = true

  # Default security group - ingress/egress rules cleared to deny all
  manage_default_security_group  = true
  default_security_group_ingress = []
  default_security_group_egress  = []

  # tag
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
  vpc_tags = {
    Name = "${var.vpc_name}-vpc"
  }
  public_subnet_tags = {
    Name = "${var.vpc_name}-public-subnet"
  }
  private_subnet_tags = {
    Name = "${var.vpc_name}-private-subnet"
  }
}
