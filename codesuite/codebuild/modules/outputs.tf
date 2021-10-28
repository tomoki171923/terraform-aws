output "iam" {
  value = {
    policy = module.codebuild_policy
    role   = module.codebuild_role
  }
}
