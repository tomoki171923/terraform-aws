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
  vpc_security_group_ids = [module.network.security_group.ssm.id]
  depends_on = [
    module.network,
    module.iam,
  ]
}

module "ssm" {
  source = "../modules/ssm"
}
