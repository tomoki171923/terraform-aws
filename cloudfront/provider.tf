provider "aws" {å
  region  = var.aws_region
  profile = var.aws_profile
  version = "~> 3.35"
}