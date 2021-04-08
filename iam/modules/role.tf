# ********************************* #
# IAM role
# ref: https://github.com/terraform-aws-modules/terraform-aws-iam/blob/master/examples/iam-assumable-role/main.tf
# ********************************* #

/* EXAMPLE
module "iam_assumable_role_custom" {
  # remote module 
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"

  trusted_role_arns = [
    "arn:aws:iam::${data.aws_caller_identity.this.account_id}:root",
  ]

  trusted_role_services = [
    "ec2.amazonaws.com"
  ]

  create_role = true

  role_name         = "s3-full-access-role"
  role_requires_mfa = false

  role_sts_externalid = "s3-full-access-role"

  custom_role_policy_arns = [
    module.s3_full_access_iam_policy.arn
  ]
}
*/


module "role_lambda_execute" {
  # remote module 
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"

  trusted_role_services = [
    "lambda.amazonaws.com"
  ]
  create_role = true
  role_name         = "LambdaExecute"
  role_description ="Lambda Execute"
  role_requires_mfa = false

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/AWSLambdaExecute"
  ]
}

module "role_lambda_invoke" {
  # remote module 
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"

  trusted_role_services = [
    "lambda.amazonaws.com"
  ]
  create_role = true
  role_name         = "LambdaInvoke"
  role_description ="Lambda Invoke"
  role_requires_mfa = false

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/AWSLambdaExecute",
    "arn:aws:iam::aws:policy/service-role/AWSLambdaRole"
  ]
}

module "role_lambda_execute_dynamodb_admin" {
  # remote module 
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"

  trusted_role_services = [
    "lambda.amazonaws.com"
  ]
  create_role = true
  role_name         = "LambdaExecuteDynamodbAdmin"
  role_description ="Lambda Execute & Dynamodb Admin"
  role_requires_mfa = false

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/AWSLambdaExecute",
    "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
  ]
}

module "role_lambda_execute_dynamodb_read" {
  # remote module 
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"

  trusted_role_services = [
    "lambda.amazonaws.com"
  ]
  create_role = true
  role_name         = "LambdaExecuteDynamodbRead"
  role_description ="Lambda Execute & Dynamodb Read"
  role_requires_mfa = false

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/AWSLambdaExecute",
    "arn:aws:iam::aws:policy/AmazonDynamoDBReadOnlyAccess"
  ]
}

module "role_lambda_execute_cloudwatch_admin" {
  # remote module 
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"

  trusted_role_services = [
    "lambda.amazonaws.com"
  ]
  create_role = true
  role_name         = "LambdaExecuteCloudWatchAdmin"
  role_description ="Lambda Execute & CloudWatc Admin"
  role_requires_mfa = false

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/AWSLambdaExecute",
    "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
  ]
}

module "role_lambda_execute_s3_admin" {
  # remote module 
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"

  trusted_role_services = [
    "lambda.amazonaws.com"
  ]
  create_role = true
  role_name         = "LambdaExecuteS3Admin"
  role_description ="Lambda Execute & S3 Admin"
  role_requires_mfa = false

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/AWSLambdaExecute",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  ]
}

module "role_lambda_execute_s3_read" {
  # remote module 
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"

  trusted_role_services = [
    "lambda.amazonaws.com"
  ]
  create_role = true
  role_name         = "LambdaExecuteS3Read"
  role_description ="Lambda Execute & S3 Read"
  role_requires_mfa = false

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/AWSLambdaExecute",
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  ]
}

module "role_lambda_execute_dynamodb_admin_s3_admin" {
  # remote module 
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"

  trusted_role_services = [
    "lambda.amazonaws.com"
  ]
  create_role = true
  role_name         = "LambdaExecuteDynamodbAdminS3Admin"
  role_description ="Lambda Execute & Dynamodb Admin & S3 Admin"
  role_requires_mfa = false

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/AWSLambdaExecute",
    "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  ]
}