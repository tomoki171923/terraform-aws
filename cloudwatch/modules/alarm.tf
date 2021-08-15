# ********************************* #
# CloudWatch Alarm
# ref: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm
# ********************************* #

resource "aws_cloudwatch_metric_alarm" "lambda_hello_world_dev_error" {
  alarm_name                = "ERROR_LAMBDA_${local.lambda_function_name}_${local.lambda_alias_name}"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "1" # min
  metric_name               = "Errors"
  namespace                 = "AWS/Lambda"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = "0"
  alarm_description         = "lambda error function:${local.lambda_function_name} alias:${local.lambda_alias_name}"
  treat_missing_data        = "missing"
  insufficient_data_actions = []
  actions_enabled           = true
  alarm_actions = [
    data.aws_sns_topic.lambda_alarms.arn
  ]
  dimensions = {
    FunctionName = local.lambda_function_name,
    Resource     = "${local.lambda_function_name}:${local.lambda_alias_name}"
  }
  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}
