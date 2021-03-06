# backend
terraform {
  required_version = ">= 0.14"

  # backendはterraform{}ブロック内に定義される
  backend "s3" {
    bucket = "infra-dev-terraform"   #このS3 bucketが先に作られている必要がある
    key    = "iam/terraform.tfstate" # .tfstateをS3 bucket内にObjectとして保存
    region = "ap-northeast-1"
    #dynamodb_table = "infra-production-terraform-state-lock" # dynamoDBを使ってState Lockを有効化(先に作成する必要がある)
    encrypt = true
  }
}