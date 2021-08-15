data "aws_lambda_alias" "hello_world_dev" {
  function_name = "hello_world"
  name          = "dev"
}

data "aws_sns_topic" "lambda_alarms" {
  name = "lambda_alarms"
}