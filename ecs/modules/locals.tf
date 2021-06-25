
locals {
  base_name             = "ecs-test"
  region                = "ap-northeast-1"
  vpc_cidr              = "10.0.0.0/16"
  public_subnet_1_cidr  = "10.0.1.0/24"
  public_subnet_2_cidr  = "10.0.2.0/24"
  private_subnet_1_cidr = "10.0.3.0/24"
  private_subnet_2_cidr = "10.0.4.0/24"
  internet_cidr_block   = "0.0.0.0/0"

  ecs_cluster_name = "${local.base_name}-cluster"
}
