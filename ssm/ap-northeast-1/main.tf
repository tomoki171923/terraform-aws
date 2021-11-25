module "network" {
  source = "../modules/network"
}

module "iam" {
  source = "../modules/iam"
}


#  depends_on = [module.iam_user_ssm_user]
