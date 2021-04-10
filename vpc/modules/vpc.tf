# ********************************* #
# VPC
# ref: https://github.com/terraform-aws-modules/terraform-aws-vpc/blob/master/examples/complete-vpc/main.tf
# ********************************* #

module "vpc" {
  # remote module 
  source = "terraform-aws-modules/vpc/aws"
  create_vpc = true
  name = "${var.vpc_name}-vpc"
  cidr = "10.100.0.0/16"

  azs             = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
  public_subnets  = ["10.100.1.0/24", "10.100.2.0/24"]
  private_subnets = ["10.100.101.0/24", "10.100.102.0/24"]
  #database_subnets    = ["10.100.21.0/24", "10.100.22.0/24"]
  #intra_subnets       = ["10.100.31.0/24", "10.100.32.0/24"]

  enable_ipv6 = false

  # nat gateway
  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  # s3 endpoint
  enable_s3_endpoint = true

  # dynamodb endpoint
  #enable_dynamodb_endpoint = true

  public_subnet_tags = {
    Name = "${var.vpc_name}-public-subnet"
  }

  private_subnet_tags = {
    Name = "${var.vpc_name}-private-subnet"
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }

  vpc_tags = {
    Name = "${var.vpc_name}-vpc"
  }
}