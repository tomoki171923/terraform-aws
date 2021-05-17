data "aws_iam_role" "LambdaExecute" {
  name = "LambdaExecute"
}

data "terraform_remote_state" "this" {
  backend = "s3"
  config = {
    bucket = "infra-develop-terraform"
    key    = "lambda/ap-northeast-1/terraform.tfstate"
    region = "ap-northeast-1"
  }
}