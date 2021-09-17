
locals {
  # route53/acm remote state
  route53_state = data.terraform_remote_state.route53.outputs.route53
  acm_state     = data.terraform_remote_state.acm.outputs.acm
  ecr_state     = data.terraform_remote_state.ecr.outputs.ecr

  base_name   = "ecs-sample"
  region      = data.aws_region.current.name
  domain_name = "ecs.${local.route53_state.zone.main.name}"

  # vpc
  vpc_cidr              = "10.0.0.0/16"
  public_subnet_a_cidr  = "10.0.1.0/24"
  public_subnet_c_cidr  = "10.0.2.0/24"
  private_subnet_a_cidr = "10.0.3.0/24"
  private_subnet_c_cidr = "10.0.4.0/24"
  internet_cidr_block   = "0.0.0.0/0"

  # ecs
  ecs_cluster_name = "${local.base_name}-cluster"
  ecs_service_name = "${local.base_name}-service"

  # conatiner
  container_name      = "sample-app"
  container_port      = 8080
  desired_task_number = 2
}
