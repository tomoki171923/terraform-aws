locals {
  event_date = "14"
  event = {
    hello_world = {
      schedule_expression = "cron(0 0 ${local.event_date} * ? *)" # AM 9:00(JST)
    }
  }
  lambda_alias_arn     = data.aws_lambda_alias.hello_world_dev.arn
  lambda_alias_name    = data.aws_lambda_alias.hello_world_dev.name
  lambda_function_name = data.aws_lambda_alias.hello_world_dev.function_name
}