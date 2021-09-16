
locals {
  # acm remote state
  acm_state = data.terraform_remote_state.acm.outputs.acm
  base_name = "ecs-sample"
  region    = "ap-northeast-1"

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
  docker_image_ur       = ""
  memory                = ""
  docker_container_port = ""
  spring_profile        = ""
  desired_task_number   = ""
}
