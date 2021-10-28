module "codebuild" {
  source       = "../modules"
  github_token = var.github_token
}
