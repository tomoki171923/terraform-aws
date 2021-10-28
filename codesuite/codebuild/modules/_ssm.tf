resource "aws_ssm_parameter" "secret" {
  name        = "/codebuild/${var.build_project_name}"
  description = "git hub token for codebuild ${var.build_project_name} project"
  type        = "SecureString"
  value       = var.github_token

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
