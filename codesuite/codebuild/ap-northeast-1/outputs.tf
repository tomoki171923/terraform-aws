output "iam" {
  value = module.codebuild.iam
}

output "project" {
  value = module.codebuild.project
}

output "credential" {
  value     = module.codebuild.credential
  sensitive = true
}

output "ssm" {
  value     = module.codebuild.ssm
  sensitive = true
}
