locals {
  route53_state = data.terraform_remote_state.route53.outputs.route53

  main_domain_name = local.route53_state.zone.main.name
  zone_id          = local.route53_state.zone.main.id

}
