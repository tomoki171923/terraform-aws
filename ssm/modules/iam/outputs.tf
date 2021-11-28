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
    policy_kms_core   = module.policy_kms_core
  }
}

output "role" {
  value = {
    ec2_ssm_managed = module.role_ec2_ssm_managed
    task_exec_role  = module.role_task_exec_role
    task_role       = module.role_task_role
  }
}

output "instance_profile" {
  value = {
    ssm_instance_profile = aws_iam_instance_profile.ssm_instance_profile
  }
}
