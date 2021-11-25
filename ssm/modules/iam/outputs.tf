output "group" {
  value = {
    ssm_members = module.iam_group_ssm_members
  }
}

output "user" {
  sensitive = true
  value = {
    ssm_user = module.iam_user_ssm_user
  }
}

output "policy" {
  value = {
    ssm_start_session = module.policy_ssm_start_session
  }
}
