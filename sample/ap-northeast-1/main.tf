module "sample" {
  source      = "../modules"
  ec2_single  = true
  ec2_clb     = false
  ec2_alb     = false
  fargate_alb = false
}
