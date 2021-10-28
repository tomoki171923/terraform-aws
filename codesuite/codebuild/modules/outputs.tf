output "iam" {
  value = {
    policy = module.codebuild_policy
    role   = module.codebuild_role
  }
}

output "project" {
  value = aws_codebuild_project.sample
}

output "credential" {
  value     = aws_codebuild_source_credential.secret
  sensitive = true
}

output "ssm" {
  value     = aws_ssm_parameter.secret
  sensitive = true
}
