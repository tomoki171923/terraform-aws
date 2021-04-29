output "iam" {
  value = {
    group  = module.iam.group
    user   = module.iam.user
    role   = module.iam.role
    policy = module.iam.policy
  }
}