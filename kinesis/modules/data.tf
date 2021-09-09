data "terraform_remote_state" "es" {
  backend = "s3"
  config = {
    bucket = "infra-develop-terraform"
    key    = "es/amazon-es/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

data "terraform_remote_state" "s3" {
  backend = "s3"
  config = {
    bucket = "infra-develop-terraform"
    key    = "s3/terraform.tfstate"
    region = "ap-northeast-1"
  }
}
