output "vpc" {
  value = {
    vpc            = module.vpc.vpc
    security_group = module.vpc.security_group
  }
}