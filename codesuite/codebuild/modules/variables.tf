# *********** Variables *********** #

/*
  Basic
*/
variable "build_project_name" {
  type    = string
  default = "sample"
}

variable "description" {
  type    = string
  default = "sample build project"
}

variable "build_timeout" {
  type    = number
  default = 5
}

variable "queued_timeout" {
  type    = number
  default = 5
}


/*
  Environment
*/
variable "environment_compute_type" {
  type    = string
  default = "BUILD_GENERAL1_SMALL"
}

variable "environment_image" {
  type    = string
  default = "aws/codebuild/standard:3.0"
}

variable "environment_type" {
  type    = string
  default = "LINUX_CONTAINER"
}

variable "environment_image_pull_credentials_type" {
  type    = string
  default = "CODEBUILD"
}

variable "environment_environment_variable" {
  type = list(
    object({
      name  = string,
      value = string,
      type  = string
    })
  )
  default = []
}

/*
  Source
*/
variable "source_location" {
  type    = string
  default = "https://github.com/tomoki171923/codebuild-sample.git"
}
variable "source_git_clone_depth" {
  type    = number
  default = 1
}

/*
  Secure
*/
variable "github_token" {
  type = string
}
