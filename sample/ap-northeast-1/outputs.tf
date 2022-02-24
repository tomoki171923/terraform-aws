output "iam" {
  value = module.sample.iam
}
output "vpc" {
  value = {
    vpc    = module.sample.vpc
    subnet = module.sample.subnet
  }
}
output "endpoints" {
  value = module.sample.endpoints
}
output "security_group" {
  value = module.sample.security_group
}
output "ecr" {
  value = module.sample.ecr
}
output "computing" {
  value = module.sample.computing
}
