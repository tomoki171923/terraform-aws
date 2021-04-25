# ********************************* #
# Lambda Function
# ref: https://github.com/terraform-aws-modules/terraform-aws-lambda
#    : https://github.com/terraform-aws-modules/terraform-aws-lambda/blob/master/examples/build-package/main.tf
# ********************************* #


# TODO: alias
module "function_hello_world" {
  source = "terraform-aws-modules/lambda/aws"

  create_function = true
  create_layer    = false
  create_role     = false

  function_name = "hello_world"
  description   = "hello world function"
  handler       = "hello_world.lambda_handler"
  runtime       = "python3.8"

  source_path = [
    "${path.module}/../src/function/hello_world.py"
  ]
  layers = [
    module.layer_base.this_lambda_layer_arn
  ]

  lambda_role            = data.aws_iam_role.LambdaExecute.arn
  memory_size            = 128
  timeout                = 3
  maximum_retry_attempts = 2
  environment_variables = {
    ENV_TEST = "EnvironmentVariableTest"
  }
  publish = true

  use_existing_cloudwatch_log_group = false
  cloudwatch_logs_retention_in_days = 30
  cloudwatch_logs_tags = {
    Terraform = "true"
  }

  tags = {
    Terraform = "true"
  }
}
