# ********************************* #
# Lambda Function
# ref: https://github.com/terraform-aws-modules/terraform-aws-lambda
#    : https://github.com/terraform-aws-modules/terraform-aws-lambda/blob/master/examples/build-package/main.tf
#    : https://github.com/terraform-aws-modules/terraform-aws-lambda/blob/master/examples/alias/main.tf
# ********************************* #

locals {
  this_state           = data.terraform_remote_state.this
  function_version_st  = local.this_state.outputs == {} ? module.function_hello_world.lambda_function_version : local.this_state.outputs.lambda.function.hello_world.alias.st.lambda_alias_function_version
  function_version_pro = local.this_state.outputs == {} ? module.function_hello_world.lambda_function_version : local.this_state.outputs.lambda.function.hello_world.alias.pro.lambda_alias_function_version

  alias_hello_world = {
    dev = {
      function_version = "$LATEST"
    }
    st = {
      function_version = var.alias == "st" ? module.function_hello_world.lambda_function_version : local.function_version_st
    }
    pro = {
      function_version = var.alias == "pro" ? module.function_hello_world.lambda_function_version : local.function_version_pro
    }
  }
}

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
    module.layer_base.lambda_layer_arn
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

module "alias_hello_world" {
  for_each         = local.alias_hello_world
  source           = "terraform-aws-modules/lambda/aws//modules/alias"
  create           = true
  refresh_alias    = false
  name             = each.key
  function_name    = module.function_hello_world.lambda_function_name
  function_version = each.value.function_version
}