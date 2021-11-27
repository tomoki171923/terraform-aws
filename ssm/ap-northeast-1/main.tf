module "network" {
  source    = "../modules/network"
  base_name = "SampleSSM"
}

module "iam" {
  source    = "../modules/iam"
  base_name = "SampleSSM"
}

module "ec2" {
  source                 = "../modules/ec2"
  base_name              = "SampleSSM"
  iam_instance_profile   = module.iam.instance_profile.ssm_instance_profile.name
  subnet_id              = module.network.vpc.private_subnets[0]
  vpc_security_group_ids = [module.network.security_group.ssm2ec2.id]
  depends_on = [
    module.network,
    module.iam,
  ]
}

data "aws_ecr_repository" "myecr" {
  name = "myecr"
}

module "ecs" {
  source             = "../modules/ecs"
  cluster_name       = "SampleSSM"
  service_name       = "SampleSSM"
  task_name          = "SampleSSM"
  task_role_arn      = module.iam.instance_profile.ssm_instance_profile.name
  execution_role_arn = module.iam.instance_profile.ssm_instance_profile.name
  subnets            = module.network.vpc.private_subnets
  security_groups    = [module.network.security_group.ssm2ec2.id]
  repository_url     = data.aws_ecr_repository.myecr.repository_url
  container_name     = "SampleSSMcontainer"
  container_port     = "80"
  container_tag      = "1.0.0"
  depends_on = [
    module.network,
    module.iam,
  ]
}

module "ssm" {
  source = "../modules/ssm"
}
