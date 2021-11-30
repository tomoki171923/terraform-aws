data "aws_ecr_repository" "myecr" {
  name = "myecr"
}
locals {
  base_name = "SampleSSM"
}


module "network" {
  source    = "../modules/network"
  base_name = local.base_name
}

module "iam" {
  source    = "../modules/iam"
  base_name = local.base_name
}

module "ec2" {
  count                  = 0
  source                 = "../modules/ec2"
  base_name              = local.base_name
  iam_instance_profile   = module.iam.instance_profile.ssm_instance_profile.name
  subnet_id              = module.network.vpc.private_subnets[0]
  vpc_security_group_ids = [module.network.security_group.ssm2ec2.id]
  depends_on = [
    module.network,
    module.iam,
  ]
}

module "ecs" {
  source             = "../modules/ecs"
  cluster_name       = "${local.base_name}Cluster"
  service_name       = "${local.base_name}Service"
  task_name          = "${local.base_name}Task"
  task_role_arn      = module.iam.role.task_role.iam_role_arn
  execution_role_arn = module.iam.role.task_exec_role.iam_role_arn
  subnets            = module.network.vpc.private_subnets
  security_groups    = [module.network.security_group.ssm2ec2.id]
  repository_url     = data.aws_ecr_repository.myecr.repository_url
  container_name     = "${local.base_name}Container"
  container_port     = "80"
  image_tag          = var.image_tag
  depends_on = [
    module.network,
    module.iam,
  ]
}

module "ssm" {
  source = "../modules/ssm"
}
