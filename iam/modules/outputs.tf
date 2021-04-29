output "group" {
  value = {
    admins                         = module.iam_group_aws_admins
    developers                     = module.iam_group_developers
    serverless_backend_developers  = module.iam_group_serverless_backend_developers
    serverless_frontend_developers = module.iam_group_serverless_frontend_developers
  }
}

output "user" {
  sensitive = true
  value = {
    admin = module.iam_user_admin
  }
}

output "role" {
  value = {
    lambda_execute                         = module.role_lambda_execute
    lambda_invoke                          = module.role_lambda_invoke
    lambda_execute_dynamodb_read           = module.role_lambda_execute_dynamodb_read
    lambda_execute_cloudwatch_admin        = module.role_lambda_execute_cloudwatch_admin
    lambda_execute_s3_admin                = module.role_lambda_execute_s3_admin
    lambda_execute_s3_read                 = module.role_lambda_execute_s3_read
    lambda_execute_dynamodb_admin_s3_admin = module.role_lambda_execute_dynamodb_admin_s3_admin
  }
}

output "policy" {
  value = {
    apigateway_read = module.policy_apigateway_read
  }
}