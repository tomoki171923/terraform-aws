resource "aws_codebuild_project" "sample" {
  name           = var.build_project_name
  description    = var.description
  build_timeout  = var.build_timeout
  queued_timeout = var.queued_timeout

  service_role = module.codebuild_role.iam_role_arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    type  = "LOCAL"
    modes = ["LOCAL_DOCKER_LAYER_CACHE", "LOCAL_SOURCE_CACHE"]
  }

  environment {
    compute_type                = var.environment_compute_type
    image                       = var.environment_image
    type                        = var.environment_type
    image_pull_credentials_type = var.environment_image_pull_credentials_type

    dynamic "environment_variable" {
      for_each = var.environment_environment_variable
      content {
        name  = environment_variable.value.name
        value = environment_variable.value.value
        type  = environment_variable.value.type
      }
    }
  }

  source {
    type            = "GITHUB"
    location        = var.source_location
    git_clone_depth = var.source_git_clone_depth
    git_submodules_config {
      fetch_submodules = true
    }
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_codebuild_source_credential" "secret" {
  auth_type   = "PERSONAL_ACCESS_TOKEN"
  server_type = "GITHUB"
  token       = var.github_token
}
