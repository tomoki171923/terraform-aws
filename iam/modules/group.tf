# ********************************* #
# IAM group
# ref: https://github.com/terraform-aws-modules/terraform-aws-iam/blob/master/examples/iam-group-with-policies/main.tf
# ********************************* #

module "iam_group_aws_admins" {
  # remote module 
  source = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
  name   = "AWSAdmins"
  group_users = [
    module.iam_user_admin.this_iam_user_name,
  ]
  custom_group_policy_arns = [
    var.aws_default_policies.AdministratorAccess,
  ]
}

module "iam_group_developers" {
  # remote module 
  source = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
  name   = "Developers"
  group_users = [
  ]
  custom_group_policy_arns = [
    var.aws_default_policies.IAMUserChangePassword,
    var.aws_default_policies.AWSSupportAccess
  ]
}


module "iam_group_serverless_backend_developers" {
  # remote module 
  source = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
  name   = "ServerlessBackendDevelopers"
  group_users = [
  ]
  custom_group_policy_arns = [
    var.aws_default_policies.AmazonSQSFullAccess,
    var.aws_default_policies.AWSLambda_FullAccess,
    var.aws_default_policies.AmazonS3FullAccess,
    var.aws_default_policies.CloudWatchFullAccess,
    var.aws_default_policies.AmazonDynamoDBFullAccess,
    var.aws_default_policies.CloudFrontFullAccess,
    var.aws_default_policies.AWSDataPipeline_FullAccess,
    var.aws_default_policies.AmazonSESFullAccess,
    var.aws_default_policies.AmazonAPIGatewayAdministrator
  ]
}

module "iam_group_serverless_frontend_developers" {
  # remote module 
  source = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
  name   = "ServerlessFrontendDevelopers"
  group_users = [
  ]
  custom_group_policy_arns = [
    var.aws_default_policies.AmazonS3FullAccess,
    var.aws_default_policies.CloudWatchEventsReadOnlyAccess,
    var.aws_default_policies.CloudWatchReadOnlyAccess,
    var.aws_default_policies.CloudFrontFullAccess,
    var.aws_default_policies.AmazonDynamoDBReadOnlyAccess,
    var.aws_default_policies.AWSLambda_ReadOnlyAccess,
    module.policy_apigateway_read.arn
  ]
}
