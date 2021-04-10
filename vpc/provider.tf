provider "aws" {
  #　Access keyを使っても酔いが、AWSのProfileの方が便利且つ、Secret Access Keyを間違ってGitにコミットしてしまう恐れがなく安全。
  # access_key = var.aws_access_key
  # secret_key = var.aws_secret_key

  region  = var.aws_region
  profile = var.aws_profile
  version = "~> 3.35"
}