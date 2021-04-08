# ********************************* #
# IAM group
# ref: https://github.com/terraform-aws-modules/terraform-aws-iam/blob/master/examples/iam-group-with-policies/main.tf
# ********************************* #

module "iam_group_aws_admins" {
  # remote module 
  source = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
  name = "AWSAdmins"
  group_users = [
    module.iam_user_admin.this_iam_user_name,
  ]
  custom_group_policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess",
  ]
}

module "iam_group_developers" {
  # remote module 
  source = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
  name = "Developers"
  group_users = [
  ]
  custom_group_policy_arns = [
    "arn:aws:iam::aws:policy/IAMUserChangePassword",
    "arn:aws:iam::aws:policy/AWSSupportAccess"
  ]
}


module "iam_group_serverless_backend_developers" {
  # remote module 
  source = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
  name = "ServerlessBackendDevelopers"
  group_users = [
  ]
  custom_group_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
    "arn:aws:iam::aws:policy/AWSLambda_FullAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/CloudWatchFullAccess",
    "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess",
    "arn:aws:iam::aws:policy/CloudFrontFullAccess",
    "arn:aws:iam::aws:policy/AWSDataPipeline_FullAccess",
    "arn:aws:iam::aws:policy/AmazonSESFullAccess",
    "arn:aws:iam::aws:policy/AmazonAPIGatewayAdministrator"
  ]
}

module "iam_group_serverless_frontend_developers" {
  # remote module 
  source = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
  name = "ServerlessFrontendDevelopers"
  group_users = [
  ]
  custom_group_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/CloudWatchEventsReadOnlyAccess",
    "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess",
    "arn:aws:iam::aws:policy/CloudFrontFullAccess",
    "arn:aws:iam::aws:policy/AmazonDynamoDBReadOnlyAccess",
    "arn:aws:iam::aws:policy/AWSLambda_ReadOnlyAccess"
  ]
}
