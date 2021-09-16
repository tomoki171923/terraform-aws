locals {
  route53_state = data.terraform_remote_state.route53.outputs.route53
  acm_state     = data.terraform_remote_state.acm.outputs.acm
}