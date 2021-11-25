output "network" {
  value = module.network
}

output "iam_user" {
  sensitive = true
  value     = module.iam.user
}
output "iam_group" {
  value = module.iam.group
}
output "iam_role" {
  value = module.iam.role
}
output "iam_policy" {
  value = module.iam.policy
}
output "iam_instance_profile" {
  value = module.iam.instance_profile
}

output "ec2" {
  value = module.ec2
}

output "ssm" {
  value = module.ssm
}
