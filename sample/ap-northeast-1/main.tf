module "sample" {
  source      = "../modules"
  ec2_single  = false
  ec2_clb     = false
  ec2_alb     = false
  fargate_alb = false
}
